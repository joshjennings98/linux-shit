#!/bin/bash
 
case "$(echo -e "Lock\nShutdown\nRestart\nLogout" | dmenu \
    -l 5 -fn Iosevka:size=35 -p "Power Settings:" -nb "#111111" -nf "#888888" -sb "#111111" -sf "#dddddd" -w 490 -c #-x 1110 -y 744
    "Power:" -l 4)" in
        Shutdown) shutdown 0;;
        Restart) reboot;;
        Logout) pkill x;;
	    Lock) sleep 0.1 ; slock;;
esac
