#! /bin/bash

cat /home/ubuntu/jokes/links.txt | sed 's/<link>http:\/\/www.funny.sk\/zabavny-vtip\/[0-9]*\/\(.*\)\.htm<\/link>/\1/' > /tmp/link_jokes.txt #get joke/file names

pushd pridane_vtipy

while read file    
	do
		file="${file::-1}"
		file+=".txt"
		if [ ! -f "$file" ]; then #if file with that name does not exist
			echo $file >> ../wrong_ones.txt #we have a problem
		fi
	done </tmp/link_jokes.txt

popd 
