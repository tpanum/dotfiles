#!/run/current-system/sw/bin/bash
CURRENT_WINDOW=$(xprop -id $(xdotool getwindowfocus) WM_CLASS | awk '{ print $3 }' | cut -d '"' -f2)
if [ "$CURRENT_WINDOW" = "st-256color" ]; then
    xvkbd -no-jump-pointer -xsendevent -text '\CC'
else
    xvkbd -no-jump-pointer -xsendevent -text '\Cc'
fi
