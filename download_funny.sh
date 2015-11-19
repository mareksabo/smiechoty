#! /bin/bash

cd ./www.funny.sk

while read line
do
	LINK=${line##*<link>}
	LINK=${LINK%%</link>*}  #link created
	NAME=${LINK##*/}
	NAME=${NAME%%.*}  #name of joke (also the file)
	NAME+=".txt"
	lynx --dump -nomargins $LINK > $NAME  #download plain text of the joke	
	CATEGORY=$(grep 'pridané' $NAME | grep 'pod')  
	CATEGORY=${CATEGORY##*]}  #take category of the joke
	CATEGORY=${CATEGORY%% pridal*} #removes pridal tag
	sed -i '/\[plu.png\]/,$d' $NAME
	sed -i '1,/pridané/d' $NAME  #filter text of jok
	echo -n $CATEGORY >> $NAME  #add category to last line
	#sed -i '/^$/d' $NAME  #remove empty lines
	sed -i '1,7d' $NAME  #remove first 5 lines of shit
	sed -i 's/   //' $NAME  #remove first 3 spaces
	sed -i 's/\"/\\\"/g' $NAME #add \ before each "
	sed -i s/\'/"\\\'"/ $NAME  #add \ before each '
done <links_to_download.txt

rm -rf rss links_to_download.txt new_links.txt output.txt

cd ..
bash ./fill_database.sh

