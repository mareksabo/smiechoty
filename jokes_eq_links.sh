#! /bin/bash

ROW_CNT=$(mysql --raw --batch -e 'select count(*) from jokes' -s)
LINKS_CNT=$(wc -l < ~/jokes/links.txt)

if ! [ "$ROW_CNT" -eq "$LINKS_CNT" ]; then
	message="number of jokes: $ROW_CNT"$'\n'"number of links: $LINKS_CNT"
	mail -s "Links != jokes" smiechotiny@gmail.com <<< "$message"
fi
