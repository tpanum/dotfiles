#!/run/current-system/sw/bin/bash
CURRENT_WINDOW=$(xprop -id $(xdotool getwindowfocus) WM_CLASS | awk '{ print $3 }' | cut -d '"' -f2)
if [ "$CURRENT_WINDOW" = "Alacritty" ]; then
    xdotool key --delay 0 --clearmodifiers ctrl+shift+v
else
    xdotool key --delay 0 --clearmodifiers ctrl+v
fi
