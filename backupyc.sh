#!/bin/sh
getDate() {
	date '+%d%m%Y'
}
getDate1() {
	date '+%d%m%Y' --date='3 days ago'
}
now=$(getDate)
del=$(getDate1)

for disk in `yc compute disk list | awk -F"|" '/backup/ {print $3}' | sed s/' '//g`
do
    yc compute snapshot create --name ${disk}-$now --disk-name ${disk}
done


for disk in `yc compute disk list | awk -F"|" '/backup/ {print $3}' | sed s/' '//g`
do
    yc compute snapshot delete --name ${disk}-$del
done
