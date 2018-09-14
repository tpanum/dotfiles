#!/run/current-system/sw/bin/bash
CURRENT_WINDOW=$(xdotool getwindowfocus getwindowname)
if [ "$CURRENT_WINDOW" = "Alacritty" ]; then
    echo "x has the value 'valid'"
    xdotool key --delay 0 --clearmodifiers ctrl+shift+c
else
    xdotool key --delay 0 --clearmodifiers ctrl+c
fi
