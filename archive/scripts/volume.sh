#!/run/current-system/sw/bin/bash
subcommand="$1"
sinks=$(pactl list sinks | sed -e 's/Sink #//g' | grep -P "^[0-9]+" )

case $subcommand in
    "up")
	echo "$sinks" | xargs -I {} pactl set-sink-volume {} +5%
	;;
    "down")
	echo "$sinks" | xargs -I {} pactl set-sink-volume {} -5%
	;;
    "mute")
	echo "$sinks" | xargs -I {} pactl set-sink-mute {} toggle
	;;
esac
