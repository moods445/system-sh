#!/bin/bash
num=2
for  i in `logread   | grep Invalid | cut -f12 -d' ' | sort | uniq -c| sort -rn| awk '{if ($1 > $num){print $2}}'`
do
	ipset test blacklist $i | grep -i not
	if [ $? -eq 0 ]; then
	   echo $i >> /var/log/deny.log
	   ipset add blacklist $i
   fi
done

