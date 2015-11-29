#! /bin/bash

cat /home/ubuntu/jokes/links.txt | sed 's/<link>http:\/\/www.funny.sk\/zabavny-vtip\/[0-9]*\/\(.*\)\.htm<\/link>/\1/' > /tmp/link_jokes.txt #get joke/file names

pushd pridane_vtipy > /dev/null

while read file    
	do
		file="${file::-1}"
		file+=".txt"
		if [ ! -f "$file" ]; then #if file with that name does not exist
			echo $file >> ../wrong_ones.txt #we have link without txt file
		fi
	done </tmp/link_jokes.txt
# check links vs. txt
if [ -f ../wrong_ones.txt ]; then
  { cat ../wrong_ones.txt; }  | mail -s "links != txt files" smiechotiny@gmail.com
fi
# check if there is a problem with inserting jokes/categories
if [ -f /home/ubuntu/jokes/insert_error.txt ]; then
  { cat ../insert_error.txt; }  | mail -s "Insert failed" smiechotiny@gmail.com
fi
popd > /dev/null
