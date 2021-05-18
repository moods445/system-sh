#!/bin/bash
num=2
for  i in `logread   | grep Disconnected | cut -f13 -d' ' | sort | uniq -c| sort -rn| awk '{if ($1 > $num){print $2}}'`
do
	ipset test blacklist $i
	if [ $? -ne 0 ]; then
       echo "into blacklist"
	   echo $i >> /var/log/deny.log
	   ipset add blacklist $i
   fi
done

