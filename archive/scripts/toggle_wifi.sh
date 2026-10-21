#!/bin/sh
subcommand=$(nmcli radio wifi)

case $subcommand in
    "enabled")
	nmcli radio wifi off
	notify-send -t 15000 --app-name="wifi" --category "off" "WiFi" "WiFi has been disabled"
	;;
    "disabled")
	nmcli radio wifi on
	notify-send -t 15000 --app-name="wifi" --category "on" "WiFi" "WiFi has been enabled"
	;;
esac
