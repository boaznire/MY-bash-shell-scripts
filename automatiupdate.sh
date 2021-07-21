#!/bin/bash

#This script is for home servers or test servers but should be carful with enterprise enviroment
#as the outcome cannot be predicted 

#In oredr to seperate the original output of list --upgradable we need to direct it into files
#one file will run the update and the another will be used to report us with the packges names instaled

if [ ! -e upgrade1.sh ];then
touch /tmp/upgrade1.sh
touch /tmp/upgrade1.txt
fi

sudo apt list --upgradable > /tmp/upgrade1.sh
sed -i 's/\/.*//g' /tmp/upgrade1.sh
sed -i '1,1d' /tmp/upgrade1.sh
cat /tmp/upgrade1.sh > /tmp/upgrade1.txt 
sed -i 's/^/yes | sudo apt install /g' /tmp/upgrade1.sh

#The script will direct the output into logfile so we can keep on track with the outcome
###### please add path
#add path for the log and uncomment the next line
#bash /tmp/upgrade1.sh > /path/updates_$(date +%d-%m-%Y).log

#The script will double check, the upgradable DB should be empty in this stage
sudo apt list --upgradable > /tmp/doublecheck.txt

FILESIZE1=$( wc -l /tmp/doublecheck.txt | awk '{print $1}')
FILESIZE2=$( wc -l /tmp/upgrade1.sh | awk '{print $1}')

if [ -s /tmp/upgrade1.txt ];then
count=$(wc -l /tmp/upgrade1.txt | awk '{print $1}')
echo
fi

#In case that any error will occure and prevent the packge/s to be installed the script to modify 
#If the packges installed successfully we will receive email with the list of packges installed and how many

if [ $FILESIZE1 -gt 1 ];then
echo "Please check for the root cause!" | mail -s "Your Ubuntu server was not updated due to error" boaz>
exit
fi

if [ $FILESIZE2 -eq 0 ];then
 echo "No updates" | mail -s "Your Ubuntu server has been updated" boaznire@gmail.com
else 
sudo echo >> /tmp/upgrade1.txt
sudo echo "Total updates: $count" >> /tmp/upgrade1.txt
cat /tmp/upgrade1.txt | mail -s "Your ubuntu server has been updated" boaznire@gmail.com
fi
