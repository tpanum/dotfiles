#!/run/current-system/sw/bin/bash
subcommand="$1"
shift || (echo "Please specify one of: full, selected, window, clipboard" && exit)

case $subcommand in
    "full")
	scrot "/home/tpanum/Pictures/screenshots/%Y-%m-%d_$wx$h.png"
	;;
    "selected")
	# delay required by dwm
	sleep 0.5 && scrot -s "/home/tpanum/Pictures/screenshots/%Y-%m-%d_$wx$h.png"
	;;
    "window")
	scrot -u "/home/tpanum/Pictures/screenshots/%Y-%m-%d_$wx$h.png"
	;;
    "clipboard")
	scrot -s '/tmp/%Y-%m-%d_$wx$h.png' -e 'xclip -selection clipboard -target image/png -i $f'
	;;
esac
