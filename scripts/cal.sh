#!/usr/bin/env bash

rofi_command="rofi -theme ~/linux-stuff/rofi/cal.rasi"

if [ "$#" -eq 0 ] ;
then
	x=`date +'%A %d %B'`
	currDay=`date +%d`
	month=`date +%m`
	startDay=`date -d "$currDay days ago" +%u`
	day="$(python3 ~/linux-stuff/scripts/cal.py | $rofi_command -p "$x" -dmenu -columns 6 -selected-row $((currDay+startDay+6)) -location 3 -yoffset 54)"
else
	x=`date -d 'next month' +'%B %Y'`
	currDay=`date +%u`
	m=`date -d 'next month' +%m`
	day="$(python3 ~/linux-stuff/scripts/cal.py $1 | $rofi_command -p "$x" -dmenu -columns 6 -selected-row $((currDay-1)) -location 3 -yoffset 54)"
fi

if [[ $day =~ [0-9]+ ]] ; then
	sh ~/linux-stuff/scripts/createEvent.sh $day $month
else
	if [[ $day =~ [A-Z]+ ]] ; then
		date="$(date +'%Y')/$month/$(date +'%d')"
		addr="https://calendar.google.com/calendar/b/1/r/month/$date"
		firefox -new-tab $addr
	fi
fi


