#! /bin/bash

mysql -e "TRUNCATE table jokes"
mysql -e "TRUNCATE table categories"

rm pridane_vtipy/*
rm wrong_jokes/*
