#!/usr/bin/env bash
#
# Print's the current screen index (zero based).
#

# Get the window position
eval "$(xdotool getmouselocation --shell)"

# Only got 2 screens so just check the X coord. Faster than other methods
if [ $X -ge 2736 ] ; then
    echo "1" 
else
    echo "0"
fi
