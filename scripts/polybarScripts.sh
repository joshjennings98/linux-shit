#!/usr/bin/env bash

# Return VPN status for polybar expressVPN module
getVPNStatus() {
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
}

# Toggle expressVPN
toggleVPN() {
    if [[ $(expressvpn status) == *"Connected"* ]] ; then 
        expressvpn disconnect ; 
    else 
        expressvpn connect ; 
    fi
}

# Return internet status for polybar internet module
getInternetStatus() {
    if [ $( iwgetid --raw ) ]; then 
        echo %{F#ffa500}%{F-} $(iwgetid --raw) ; 
    elif [[ $(nmcli) == *"connected to Wired connection"* ]] ; then
        echo %{F#ffa500}%{F-} Ethernet ;
    else 
        echo %{F#f00}'no internet'%{F-} ; 
    fi
}

# Main entry
main()
{
    # Parse input args
    case $1 in
        "internetStatus")
            getInternetStatus ;;
        "toggleVPN")
            toggleVPN ;;
        "statusVPN")
            getVPNStatus ;;
        *)
        ;;
    esac
}

main "$@"
