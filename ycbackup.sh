#!/bin/bash
getDate() {
	date '+%d%m%Y'
}
getDate1() {
	date '+%d%m%Y' --date='3 days ago'
}
now=$(getDate)
del=$(getDate1)


for disk in `yc compute disk list --folder-id "id вашей папки" | awk -F"|" '/backup/ {print $3}' | sed s/' '//g`
do
    (
        yc compute snapshot create --folder-id "id вашей папки" --name ${disk}-$now --disk-name ${disk} &&\
        yc compute snapshot delete --folder-id "id вашей папки" --name ${disk}-$del
    ) & disown
done
