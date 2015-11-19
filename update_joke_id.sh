#! /bin/bash
mysql -u ubuntu -e "SELECT MAX(joke_id) FROM jokes;" | sed "s/^MAX(joke_id)$//" | tr -d n > /var/www/html/lastid.html
