#!/bin/bash
lvmn=$(lsblk | grep lvm | wc -l)
tcpc=$(ss -atr | grep ESTAB | wc -l)

wall "
	#Architecture: `uname -a`
	#Physical CPUs: `nproc --all`
	#Virtual CPUs: `cat /proc/cpuinfo | grep processor | wc -l`
	#Memory usage: `free -m | grep Mem | awk '{printf "%dMB/%dMB (%d%%)", $3, $4, $3/$4 * 100}'`
	#Disk usage: `df -Bg | awk '{SUM1 += $3} {SUM2 += $2} END {print SUM1 "GB/" SUM2 "GB"}'`
	#CPU load: `df -h | awk '{SUM += $5} END {print SUM "%"}'`
	#Last boot: `who -b | awk -F' ' '{print $3 " " $4}'` 
	#LVM use: `if [ $lvmn -eq 0 ]; then echo no; else echo yes; fi`
	#TCP Connections: $tcpc ESTABLISHED
	#User log: `who | cut -d " " -f 1 | sort -u | wc -l`
	#Network IP: `hostname -I | awk '{print }'` `cat /sys/class/net/*/address | head -1 | awk '{print "(" $1 ")"}'`
	#Sudo: `cat /var/log/sudo/sudo.log | grep COMMAND | wc -l`
"
