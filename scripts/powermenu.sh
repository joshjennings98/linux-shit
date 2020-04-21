#!/usr/bin/env bash

rofi_command="rofi -theme ~/linux-stuff/rofi/powermenu.rasi"
uptime=$(uptime -p | sed -e 's/up //g')

# Options
lock=" "
shutdown="-e "
logout="-e "

# Variable passed to rofi
options="$lock\n$logout\n$shutdown"

chosen="$(echo -e  "$options" | $rofi_command -p "Uptime - $uptime" -dmenu -selected-row 0)"
case $chosen in
    "-e $lock")
	scrot /tmp/screenshot.png ; convert /tmp/screenshot.png -blur 0x8 /tmp/screenshotblur.png ; i3lock -i /tmp/screenshotblur.png
        ;;
    $shutdown)
        systemctl poweroff
        ;;
    $logout)
        i3-msg exit
        ;;
    *)
	;;
esac

