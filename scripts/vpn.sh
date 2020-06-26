#!/bin/bash

status=$(expressvpn status)

recommendedLocations=("UK" "Germany" "Netherlands" "USA" "France" "Switzerland" "Italy" "Sweden" "Spain" "Belgium")

loc="(non recommended country)"

for l in ${recommendedLocations[@]}; do
    if [  $(echo $status | grep -ioE $l) ] ; then loc=$l ; fi
done

if $(expressvpn status | grep -q 'Connected') ;
    then echo "%{F#3CB371} %{F-}$loc " ;
elif $(expressvpn status | grep -q 'Connecting') ;
    then echo "%{F#3CB371}%{F-} %{F#666}connecting %{F-}" ;
else
    echo "%{F#f00} off %{F-}" ;
fi

