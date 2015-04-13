#! /bin/bash
cd jokes

wget -Nrkpl 0 http://www.funny.sk/rss  #download source
    
cd ./www.funny.sk #THIS MUST BE CHANGED ON SERVER

grep '<link>' rss > output.txt  #choose all links
grep 'zabavny-vtip' output.txt > new_links.txt #choose only links with jokes

comm -2 -3 <(sort new_links.txt) <(sort /home/ubuntu/jokes/links.txt) > links_to_download.txt #filters only new added links on rss

cat links_to_download.txt >> /home/ubuntu/jokes/links.txt #adds all new links to global file with links
sed -i '/^$/d' /home/ubuntu/jokes/links.txt

cd ..
if [[ ! -s links_to_download.txt ]] ; then  #if there are any new links
  bash ~/jokes/download_funny.sh #then download them
fi
