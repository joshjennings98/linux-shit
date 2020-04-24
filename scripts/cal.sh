#!/usr/bin/env bash

rofi_command="rofi -theme ~/linux-stuff/rofi/cal.rasi"

x=`date +'%A %d %B'`
hh=`date +%u`

python3 ~/linux-stuff/scripts/cal.py | $rofi_command -p "$x" -dmenu -columns 5 -selected-row $((hh-1)) -location 3 -yoffset 54
