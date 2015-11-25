#! /bin/bash

FILES=/home/ubuntu/jokes/www.funny.sk/* #loads all files from www.funny.sk directory

for file in $FILES #iterate over the files
do
		text=$(head -n -1 $file) #text is all lines except last one
		category=$(tail -2 $file) #category name is last line
		name=$(basename $file) 
		name="${name%.*}" #name of joke is equal to name of file containing joke without .txt
		num_of_rows=$(mysql --raw --batch -e 'select count(*) from categories' -s) #get number of rows in categories
		number=-1
		category=${category:1} #remove newline character from beginning of string
		for id in $(seq 1 $num_of_rows) #iterate over all categories
		do
			categ_from_DB=$(mysql --silent -e "SELECT name FROM categories where category_id=$id")	 #select name of category with ID == id
			if [ "$category" == "$categ_from_DB" ]; then #if category is in DB, actualize ID !!! PROBLEM? !!!
				number=$id
				break
			fi
		done
		if [ "$number" -eq -1 ]; then #if category wasnt find in DB, add it
			$(mysql -e "INSERT INTO categories (name) VALUES ('$category');" )
			if [ "$?" -ne 0 ]; then
		  	echo "Insert category: -$category- error" >> error.txt
			fi
			number=$(mysql -se "SELECT category_id FROM categories where name like '$category'") #and get its ID
		fi

		#insert joke
		if [ -n "$text" ]; then #if text is not null
			$(mysql -e "INSERT INTO jokes (name, text, category_id) VALUES ('$name', '$text','$number');")
			if [ "$?" -ne 0 ]; then
		    echo "Insert joke: $name error" >> error.txt
			fi	
			#TODO bash ./update_joke_id.sh #update max joke_id
		fi
		cp $file /home/ubuntu/jokes/pridane_vtipy #add joke do directory 
done

rm -rf www.funny.sk
