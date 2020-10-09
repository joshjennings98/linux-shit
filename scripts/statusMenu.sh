#!/bin/bash

# Return VPN status for polybar expressVPN module
getVPNStatus() {
    status=$(expressvpn status)

    recommendedLocations=("UK" "Germany" "Netherlands" "USA" "France" "Switzerland" "Italy" "Sweden" "Spain" "Belgium")

    loc="(non recommended country)"

    for l in ${recommendedLocations[@]}; do
        if [  $(echo $status | grep -ioE $l) ] ; then loc=$l ; fi
    done

    if $(expressvpn status | grep -q 'Connected') ;
        then VPN="VPN: Connected ($loc)" ;
    elif $(expressvpn status | grep -q 'Connecting') ;
        then VPN="VPN Connecting" ;
    else
        VPN="VPN Disconnected" ;
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

# Screenshot
screenshot() {
    timestamp=$(date +%Y-%m-%d-%Hh%Mm%Ss%3N) &&
    maim -s ~/Pictures/screenshot-$timestamp.png &&
    pinta ~/Pictures/screenshot-$timestamp.png
}

# Main function
main() {
    getVPNStatus

    case "$(echo -e "Screenshot\nVolume Settings (alsamixer)\nTask Manager (htop)\nNetwork Settings (nmtui)\n$VPN\nPower Menu" | dmenu -p "Settings Menu:" -l 6 -fn Iosevka:size=35 -nb "#111111" -nf "#888888" -sb "#111111" -sf "#dddddd" -c -w 704 #-x 2022 -y 52
        "Power:" -l 6)" in
            Volume\ Settings\ \(alsamixer\)) st -e alsamixer;;
            Network\ Settings\ \(nmtui\)) st -e nmtui;;
            $VPN) toggleVPN;;
	    Task\ Manager\ \(htop\)) st -e htop;;
            Screenshot) screenshot;;
            Power\ Menu) /home/josh/dwm/powerMenu.sh;;
    esac
}

# Entry Point
main
