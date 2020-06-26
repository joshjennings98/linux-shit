#!/bin/bash

if [ $( iwgetid --raw ) ]; then 
    echo %{F#ffa500}%{F-} $(iwgetid --raw) ; 
elif [[ $(nmcli) == *"connected to Wired connection"* ]] ; then
    echo %{F#ffa500}%{F-} Ethernet ;
else 
    echo %{F#f00}'no internet'%{F-} ; 
fi

