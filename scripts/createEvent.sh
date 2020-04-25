# Create an event at the current time on a certain day and month of the current year 

if [ $# -eq 0 ]
	then
		start=$(date '+%Y%m%dT%H%M00Z')
		end=$(date -d '-1 hour ago' '+%Y%m%dT%H%M00Z')
	else
		start="$(date '+%Y')$2$1$(date '+T%H%M00Z')"
		end="$(date '+%Y')$2$1$(date -d '-1 hour ago' '+T%H%M00Z')"
fi

event="https://calendar.google.com/calendar/b/1/r/eventedit?&dates=$start/$end"

firefox -new-tab $event

