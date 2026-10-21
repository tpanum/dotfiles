#!/bin/sh

_elem() {
    if [ -z "${@}" ]; then
	echo ""
    else
	echo "${@}  •"
    fi
}

spotify() {
    spotify_metadata=$(dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' 2> /dev/null)
    if [ $? -ne 0 ]; then
	echo ""
	exit 0
    fi

    title=$(echo "${spotify_metadata}" | grep title -A 1 | tail -n 1 | cut -f  2 -d '"')
    artist=$(echo "${spotify_metadata}" | grep artist -A 2 | tail -n 1 | cut -f  2 -d '"')
    msg="^c#A3BE8C^^d^  ${artist} - ${title}"
    echo "  ${msg}  •"
}

battery() {
    joint_info=$(paste /sys/class/power_supply/BAT0/uevent /sys/class/power_supply/BAT1/uevent | awk '{split($0,a,"="); split(a[2],b," "); (a[3] == "Charging" || b[1] == "Charging") ? $5 = "Charging" : $5 = (a[3] + b[1])/2; print a[1] "=" $5}')

    icon=""
    if echo "${joint_info}" | grep -q "STATUS=Charging"; then
	icon="^c#D8DEE9^^d^"
    else
	icon="^c#EBCB8B^^d^"
    fi

    capacity=$(echo "${joint_info}" | grep "POWER_SUPPLY_CAPACITY=" |  cut -d "=" -f2 | awk '{printf("%d\n",$1)}')

    msg=""
    if [ "$capacity" -lt "30" ]; then
	msg="${icon}  ^c#EBCB8B^${capacity}%^d^"
    elif [ "$capacity" -lt "15" ]; then
	msg="${icon}  ^c#BF616A^${capacity}%^d^"
    else
	msg="${icon}  ${capacity}%"
    fi
    echo "  ${msg}  •"
}

headphones() {
    found=$(pactl list sinks | grep "module-bluez5-device.c")
    if [ -n "$found"  ]; then
	echo " ^c#ECEFF4^^d^   •"
    fi
}

time_date() {
    date "+  %b %d %a  •  %H:%M"
}

network() {
    ssid=$(iwgetid -r)
    wifimsg=""
    if [ ! -z $ssid ]; then
	wifimsg="  ^c#D8DEE9^^d^  ${ssid}  •"
    fi

    cablemsg=""

    if ! grep -q "down" /sys/class/net/enp0s31f6/operstate; then
	cablemsg="  ^c#D8DEE9^^d^  Ethernet  •"
    fi

    echo "${wifimsg}${cablemsg}"
}

memory() {
    free -m | grep Mem | awk '{printf("  %.1f GB  •\n", $3/1024)}'
}

mullvad() {
    mullvad=$(ifconfig | grep wg-mullvad)
    if [ ! -z $mullvad ]; then
	wifimsg="  ^c#D8DEE9^^d^  ${ssid}  •"
	echo "🔒 Mullvad •"
    fi
}


headphones_var=$(headphones)
spotify_var=$(spotify)
memory_var=$(memory)
battery_var=$(battery)
network_var=$(network)
time_date_var=$(time_date)

while true
do
    s=$(date '+%s')

    if [ $(($s % 5 == 0)) -eq 1 ]; then
	time_date_var=$(time_date)
    fi

    if [ $(($s % 10 == 0)) -eq 1 ]; then
	spotify_var=$(spotify)
    fi

    if [ $(($s % 15 == 0)) -eq 1 ]; then
	memory_var=$(memory)
    fi

    if [ $(($s % 30 == 0)) -eq 1 ]; then
	battery_var=$(battery)
    fi

    if [ $(($s % 10 == 0)) -eq 1 ]; then
	network_var=$(network)
    fi

    if [ $(($s % 10 == 0)) -eq 1 ]; then
	headphones_var=$(headphones)
    fi

    xsetroot -name "${headphones_var}${spotify_var}${mullvad}${memory_var}${battery_var}${network_var}${time_date_var}"

    sleep 1
done
