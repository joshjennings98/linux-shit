m=$(bash ~/linux-stuff/scripts/getMonitorIndex.sh)

if [ $m -eq 0 ] ; then
    rofi -monitor $m -show drun -theme ~/linux-stuff/rofi/rofi_config.rasi
else
    rofi -monitor $m -show drun -theme ~/linux-stuff/rofi/rofi_config_1080.rasi
fi
