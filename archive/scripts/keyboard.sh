#!/run/current-system/sw/bin/bash
DISPLAY=":0.0"
HOME=/home/tpanum/
XAUTHORITY=$HOME/.Xauthority
PATH="/run/current-system/sw/bin/"
export DISPLAY XAUTHORITY HOME PATH

set -e

get_kbdlayout() {
    setxkbmap -query | grep -oP 'layout:\s*\K(\w{2})'
}

set_kbdlayout() {
    if [ "$1" == "us" ]; then
	    setxkbmap "$1" -variant "altgr-intl"
	    xmodmap -e 'keycode 110 = ISO_Level3_Shift ISO_Level3_Shift ISO_Level3_Shift ISO_Level3_Shift'
    else
	setxkbmap "$1"
    fi

    uppercaseName=$(get_kbdlayout | awk '{print toupper($0)}')
    (notify-send -i "$1" "Keyboard Layout" "Switched to ${uppercaseName} Keyboard Layout" && sleep 5) &

    xmodmap ~/.Xmodmap
}

cycle() {
    current_layout=$(get_kbdlayout)
    layouts=("$@" "$1") # add the first one at the end so that it cycles
    index=0
    while [ "${layouts[$index]}" != "$current_layout" ] && [ $index -lt "${#layouts[@]}" ]; do index=$[index +1]; done
    next_index=$[index +1]
    next_layout=${layouts[$next_index]}
    set_kbdlayout "$next_layout"
}

subcommand="$1"
shift || (echo "Please specify one of: get, set <layout>, cycle <layout1> <layout2> ... <layoutN>, i3status" && exit)

case $subcommand in
    "get")
	echo -n $(get_kbdlayout)
	;;
    "set")
	set_kbdlayout "$1"
	;;
    "cycle")
	cycle "$@"
	;;
esac
