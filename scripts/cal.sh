#!/usr/bin/env bash

rofi_command="rofi -theme ~/linux-stuff/rofi/cal.rasi"

if [ "$#" -eq 0 ] ; 
then
	x=`date +'%A %d %B'`
	hh=`date +%d`
	m=`date +%m`
	startday=`date -d '$hh days ago' +%d`
	day="$(python3 ~/linux-stuff/scripts/cal.py | $rofi_command -p "$x" -dmenu -columns 6 -selected-row $((hh+startday+8)) -location 3 -yoffset 54)"
else
	x=`date -d 'next month' +'%B %Y'`
	hh=`date +%u`
	m=`date -d 'next month' +%m`
	day="$(python3 ~/linux-stuff/scripts/cal.py $1 | $rofi_command -p "$x" -dmenu -columns 6 -selected-row $((hh-1)) -location 3 -yoffset 54)"
fi

if [[ $day =~ [0-9]+ ]] ; then
	sh ~/linux-stuff/scripts/createEvent.sh $day $m
else
	if [[ $day =~ [A-Z]+ ]] ; then
		date="$(date +'%Y')/$m/$(date +'%d')"
		addr="https://calendar.google.com/calendar/b/1/r/month/$date"
		firefox -new-tab $addr
	fi
fi


