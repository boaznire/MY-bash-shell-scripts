# MY-bash-shell-scripts
personal implementation and my first version of UBUNTU opening loging spript presents a basic information about our linux system sudited for Debian and Ubuntu
In order to get the scripts results you will need to run multipescripts.sh which will run the main script statistics.sh

!/bin/bash

#This is a personal implementation and first version of UBUNTU initial logging script presents
#a basic information about our Linux system suited for Debian and Ubuntu


#PrintHow long did it take for the system to load
printf "%s\n System load:  "

LOAD=$(load=sudo cat /proc/loadavg | awk '{printf ("%s\t\t",$1)}')
echo $LOAD

#Checking temperture

sensors | grep temp1 > /tmp/memory
printf "%s Temperature: "
awk '{print $2}' /tmp/memory

#Hard drive usage
#
df -h /dev/mapper/debian--vg-root > /tmp/usage1 | sed -i '1d' /tmp/usage1
printf "%s usage of /:   "
awk '{printf("%s of ",$5)}' /tmp/usage1
df -h /dev/mapper/debian--vg-root > /tmp/usage1 | sed -i '1d' /tmp/usage1
awk '{printf ("%s\t",$2)}' /tmp/usage1

#How many active processes
#
#RAM usage
#

free -h | sed '2!d' > /tmp/memory

awk '{printf ("%s",$3)}'  /tmp/memory > /tmp/memory1
sed -i 's/[^0-9]*//g' /tmp/memory1
echo >> /tmp/memory1
RAMINUSE=$(cat /tmp/memory1)

awk '{printf ("%s",$2)}' memory.txt > memory2.txt
sed -i 's/[^.*0-9]//g' memory2.txt

PHISICALRAM=$(cat memory2.txt)
PHISICALRAM=$(expr $PHISICALRAM\*1000 | bc) 

DIVIDE=$(expr $RAMINUSE/$PHISICALRAM | bc -l)
MEMORY=$(expr $DIVIDE*100 | bc)
echo "%" > precent
PRECENT=$(cat precent)

printf "Memory usage: %.1f" $MEMORY 
printf "%s" $PRECENT

#Users logged in

USERS=$(who | wc -l)

printf "%s \t\t Users logged in: "
echo $USERS

#Checking Swap Usage
#

free -m | sed '3!d' > /tmp/memory3
printf "%s Swap Usage: "
SWAP=$(awk '{printf ("%s",$3)}' /tmp/memory3)
printf $SWAP
echo

#Get the IP address for for all interfaces
#

ip -br link show > /tmp/interface
egrep 'UNKNOWN|DOWN' /tmp/interface | sed -i '/UNKNOWN/d;/DOWN/d' /tmp/interface
COUNT=$(wc -l interface | awk '{print $1}')
echo

sed -e "$i!"d /tmp/interface > /tmp/interface2
INTERFACE=$(awk '{print $1}' /tmp/interface2)
IPADDRESS=$(hostname -I | awk '{print $'$i'}')
printf "%s\t\t\tIPv4 address for "
echo $INTERFACE": $IPADDRESS"

done
echo

echo 
echo

COUNT=$(ps -ely | wc -l)
PROCESES=$(( $COUNT-1 ))

printf "%s Processes: \t"
echo $PROCESES

