#! /bin/bash

mysql -e "TRUNCATE table jokes"
mysql -e "TRUNCATE table categories"

rm pridane_vtipy/*
rm wrong_jokes/*

# ---- creating files ---- #
mkdir www.funny.sk
cp ~/jokes/links.txt ~/jokes/www.funny.sk/links_to_download.txt
