#!/usr/bin/env bash

m=$(bash ~/linux-stuff/scripts/getMonitorIndex.sh)

if [ $m -eq 0 ] ; then
    rofi_command="rofi -theme ~/linux-stuff/rofi/powermenu.rasi"
else
    rofi_command="rofi -theme ~/linux-stuff/rofi/powermenu_1080.rasi"
fi

uptime=$(uptime -p | sed -e 's/up //g')

# Options
lock="    Lock"
shutdown="-e    Shutdown"
logout="-e    Logout"

# Variable passed to rofi
options="$lock\n$logout\n$shutdown"

# If argument then put in corner (for i3status)
if [ $# -eq 0 ]
	then
		chosen="$(echo -e  "$options" | $rofi_command -p "Enceladus - Power" -dmenu -selected-row 0)"
	else
		chosen="$(echo -e  "$options" | $rofi_command -p "Enceladus - Power" -dmenu -selected-row 0 -location 3 -yoffset 54)"
fi

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

