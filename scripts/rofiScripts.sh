#!/usr/bin/env bash

# Create an event at the current time on a certain day and month of the current year 
createEvent() {
    # Parse args   
    if [ $# -eq 0 ] # If no args then create event now
    then
	    start=$(date '+%Y%m%dT%H%M00Z')
	    end=$(date -d '-1 hour ago' '+%Y%m%dT%H%M00Z')
    else
	    if [ $1 -gt 10 ] # Whether to add leading zero to date code
	    then
		    start="$(date '+%Y')$2$1$(date '+T%H%M00Z')"
		    end="$(date '+%Y')$2$1$(date -d '-1 hour ago' '+T%H%M00Z')"
	    else
		    x=0 # Need leading zero but if it's just put in it doesn't work
		    start="$(date '+%Y')$2$x$1$(date '+T%H%M00Z')"
		    end="$(date '+%Y')$2$x$1$(date -d '-1 hour ago' '+T%H%M00Z')"
	    fi
    fi

    event="https://calendar.google.com/calendar/b/1/r/eventedit?&dates=$start/$end"
    firefox -new-tab $event
}

# Generate calendar for rofic cause cal didn't work properly
genCal() {
    dayNames=("Mo" "Tu" "We" "Th" "Fr" "Sa" "Su")
    dayNums=(31 28 31 30 31 30 31 31 30 31 30 31)

    # Get month and startday for chosen month
    if [ "$1" == "now" ] ; then
        month=$(date +%-m)
        startDay=$(($(date -d "$(date +%d) days ago" +%u)%7))
    elif [ "$1" == "next" ] ; then
        month=$(date -d "next month" +%-m)
        startDay=$(date -d "-$((${dayNums[$month]}-$(date -d "next month" +%d)+1)) days ago" +%u)
    else
        echo "Invalid arg for genCal function. Must be 'now' or 'next'."
    fi

    # Print days of week
    for day in "${dayNames[@]}"
    do
       echo "$day"
    done

    # Print nothing until start day of month
    i=1
    while [ $i -le $startDay ] ; do
        echo " "
        ((i++))
    done

    # Print day indexes
    i=1
    while [ $i -le ${dayNums[$month]} ] ; do
        echo $i
        ((i++))
    done
}

# Launch rofi calendar
cal() {
    # Create calendar for either now or next month
    if [ "$1" == "now" ] ; then
	    calendarPrompt=`date +'%A %d %B'`  
	    currDay=`date +%d`    
	    month=`date +%m`
	    startDay=`date -d "$(date +%d) days ago" +%u`   
	    day="$(genCal now | rofi -theme ~/linux-stuff/rofi/cal.rasi -p "$calendarPrompt" -dmenu -columns 6 -selected-row $((currDay+startDay%7+6)) -location 2 -yoffset 66)"	    
    elif [ "$1" == "next" ] ; then
	    calendarPrompt=`date -d 'next month' +'%B %Y'`
	    currDay=`date +%u`
	    month=`date -d "next month" +%m`
	    day="$(genCal next | rofi -theme ~/linux-stuff/rofi/cal.rasi -p "$calendarPrompt" -dmenu -columns 6 -selected-row $((currDay-1)) -location 2 -yoffset 66)"
    else
        echo "Invalid argument to cal function. Must be 'now' or 'next'."
    fi

    # Do action on click
    if [[ $day =~ [0-9]+ ]] ; then # If click on specific day then create event
	    createEvent $day $month
    else
	    if [[ $day =~ [A-Z]+ ]] ; then # If click on day of week then just load calendar website
		    date="$(date +'%Y')/$month/$(date +'%d')"
		    addr="https://calendar.google.com/calendar/b/1/r/month/$date"
		    firefox -new-tab $addr
	    fi
    fi
}

# Return index of monitor
getMonitorIndex() {
    # Get the window position
    eval "$(xdotool getmouselocation --shell)"

    # Only got 2 screens so just check the X coord. Faster than other methods
    if [ $X -ge 2736 ] ; then
        echo "1" 
    else
        echo "0"
    fi
}

# Launch rofi dmenu thing
launchRofi() {
    # Get monitor
    m=$(getMonitorIndex)
    
    # Show correct dpi version of menu
    if [ $m -eq 0 ] ; then
        rofi -monitor $m -show drun -theme ~/linux-stuff/rofi/rofi_config.rasi
    else
        rofi -monitor $m -show drun -theme ~/linux-stuff/rofi/rofi_config_1080.rasi
    fi
}

# Launch the power menu
launchPowerMenu() {
    # Get monitor
    m=$(getMonitorIndex)
    
    # Options
    lock="   Lock"
    shutdown="  Shutdown"
    logout="  Logout"

    # Variable passed to rofi
    options="$lock\n$logout\n$shutdown"

    # Show correct dpi version of menu and get the chosen action
    if [ $m -eq 0 ] ; then
        chosen="$(echo -e  "$options" | rofi -theme ~/linux-stuff/rofi/powermenu.rasi -dmenu -selected-row 0)"
    else
        chosen="$(echo -e  "$options" | rofi -theme ~/linux-stuff/rofi/powermenu_1080.rasi -dmenu -selected-row 0)"
    fi
    
    # Carry out chosen action
    case $chosen in
        $lock)
        sleep 0.1
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
}

# Main entry
main()
{
    # Parse input args
    case $1 in
        "dmenu")
            launchRofi ;;
        "power")
            launchPowerMenu ;;
        "calendar")
            cal "$2" ;;
        *)
        ;;
    esac
}

main "$@"

