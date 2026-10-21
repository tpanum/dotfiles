#!/run/current-system/sw/bin/bash
IFS='x' read screenWidth screenHeight < <(xrandr | grep primary -A 5 | grep --color -e '[0-9]\+\.[0-9]\+\*' | awk '{ print $1 }')

width=$(xdotool getactivewindow getwindowgeometry --shell | head -4 | tail -1 | sed 's/[^0-9]*//')
height=$(xdotool getactivewindow getwindowgeometry --shell | head -5 | tail -1 | sed 's/[^0-9]*//')

newPosX=$((screenWidth/2-width/2))
newPosY=$((screenHeight/2-height/2))

xdotool getactivewindow windowmove "$newPosX" "$newPosY"
