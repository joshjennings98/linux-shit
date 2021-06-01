#!/bin/bash

# Scripts for dmenu menus etc.

# Colours
export col_nb=#002b36
export col_nf=#fdf6e3
export col_sb=#93a1a1

# Info for functions
TERMINAL=st
APPS="Discord\nFirefox\nSpotify\nOrigin\nScreenshot\nFiles\nSystem Monitor\nGames\nNetwork\nBluetooth\nSettings\nPower\nSteam\nEpic Games Launcher\nLutris\nVSCode\nMinecraft"

# Screenshot script
screenshot() {
    timestamp=$(date +%Y-%m-%d-%Hh%Mm%Ss%3N) &&
    maim -s ~/Pictures/screenshot-$timestamp.png &&
    pinta ~/Pictures/screenshot-$timestamp.png
}

appMenu() { 
    APP=$(echo -e $APPS | sort -n | dmenu -i -fn 'Iosevka-12' -nb $col_nb -nf $col_nf -sb $col_sb -sf $col_nb -nhb $col_nb -shb $col_sb)

    case "$APP" in
        Screenshot) screenshot;;
        Discord) discord;;
        System\ Monitor) $TERMINAL -e htop;;
        Files) nautilus;;
        Spotify) spotify;;
        Network) $TERMINAL -e nmtui;;    
        Settings) gnome-control-center;;
        Bluetooth) blueman-manager;;
        Power) bash /home/josh/Scripts/menus.sh power;;
        Steam) steam;;
        Firefox) firefox;;
        Epic\ Games\ Launcher) lutris lutris:rungameid/1;;
        Lutris) lutris;;
        Origin) lutris lutris:rungame/origin;;
        VSCode) code;;
        Minecraft) minecraft-launcher;;
        Games) bash /home/josh/Scripts/menus.sh games;;
    esac
}

powerMenu() {
    case "$(echo -e "Lock\nShutdown\nRestart\nLogout" | dmenu -i -fn 'Iosevka-12' -nb $col_nb -nf $col_nf -sb $col_sb -sf $col_nb -nhb $col_nb -shb $col_sb)" in
        Shutdown) shutdown 0;;
        Restart) reboot;;  
        Logout) pkill x;;  
        Lock) sleep 0.1 ; slock;;
    esac
}

dmenuAll() {
    dmenu_run -i -fn 'Iosevka-12' -nb $col_nb -nf $col_nf -sb $col_sb -sf $col_nb -nhb $col_nb -shb $col_sb
}

# Games dmenu script       
gamesMenu() {                  
    case "$(echo -e "Steam\nEpic Games Launcher\nLutris\nMinecraft" | dmenu -i -fn 'Iosevka-12' -nb $col_nb -nf $col_nf -sb $col_sb -sf $col_nb -nhb $col_nb -shb $col_sb)" in
        Steam) steam;;     
        Epic\ Games\ Launcher) lutris lutris:rungameid/1;;
        Lutris) lutris;;   
        Minecraft) minecraft-launcher;; 
    esac
}

quickMenu() {
    case "$(echo -e "Screenshot\nFiles\nSystem Monitor\nGames\nNetwork\nBluetooth\nSettings\nPower" | dmenu -i -fn 'Iosevka-12' -nb $col_nb -nf $col_nf -sb $col_sb -sf $col_nb -nhb $col_nb -shb $col_sb)" in
        Screenshot) screenshot;;
        System\ Monitor) $TERMINAL -e htop;;
        Files) $TERMINAL -e ranger;;    
        Network) $TERMINAL -e nmtui;;    
        Settings) gnome-control-center;;
        Bluetooth) blueman-manager;;    
        Games) gamesMenu;;
        Power) bash /home/josh/Scripts/powerMenu.sh;;
    esac
}

case $1 in
    apps) appMenu;;
    power) powerMenu;;
    dmenu) dmenuAll;;
    quick) quickMenu;;
    games) gamesMenu;;
esac
