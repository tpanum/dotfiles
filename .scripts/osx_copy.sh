#!/run/current-system/sw/bin/bash
CURRENT_WINDOW=$(xprop -id $(xdotool getwindowfocus) WM_CLASS | awk '{ print $3 }' | cut -d '"' -f2)

case $CURRENT_WINDOW in
    Alacritty)
	xvkbd -no-jump-pointer -xsendevent -text '\CC'
	;;
    termite)
	xdotool key --delay 80 --clearmodifiers ctrl+shift+c
	;;
    urxvt)
	xvkbd -no-jump-pointer -xsendevent -text '\Ac'
	;;
    *)
	xvkbd -no-jump-pointer -xsendevent -text '\Cc'
	;;
esac
