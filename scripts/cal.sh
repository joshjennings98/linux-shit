#!/usr/bin/env bash

rofi_command="rofi -theme ~/linux-stuff/rofi/cal.rasi"

x=`date +'%A %d %B'`
hh=`date +%d`

python3 ~/linux-stuff/scripts/cal.py | $rofi_command -p "$x" -dmenu -columns 6 -selected-row $((hh+7+1)) -location 3 -yoffset 54
