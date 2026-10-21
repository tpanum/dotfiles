#!/bin/sh
is_bluetooth_blocked=$(rfkill list bluetooth | grep -E -m 1 -o "blocked: (yes|no)" | cut -d " " -f2)

case $is_bluetooth_blocked in
    "yes")
	rfkill unblock bluetooth
	notify-send -t 15000 --app-name="bluetooth" --category "on" "Bluetooth" "Bluetooth has been enabled"
	;;
    "no")
	rfkill block bluetooth
	notify-send -t 15000 --app-name="bluetooth" --category "off" "Bluetooth" "Bluetooth has been disabled"
	;;
esac
