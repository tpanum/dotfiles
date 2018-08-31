#!/usr/bin/env bash

# Enable compton's fade-in effect so that the lockscreen gets a nice fade-in
# effect.
# dbus-send --print-reply --dest=com.github.chjj.compton.${DISPLAY/:/_} / \
    #     com.github.chjj.compton.opts_set string:no_fading_openclose boolean:false

# If disable unredir_if_possible is enabled in compton's config, we may need to
# disable that to avoid flickering. YMMV. To try that, uncomment the following
# two lines and the last two lines in this script.
# dbus-send --print-reply --dest=com.github.chjj.compton.${DISPLAY/:/_} / \
#     com.github.chjj.compton.opts_set string:unredir_if_possible boolean:false

# Suspend dunst and lock, then resume dunst when unlocked.
pkill -u $USER -USR1 dunst
i3lock-color -n -i $HOME/.wallpaper/.cache/current \
	     --insidecolor=373445ff --ringcolor=ffffffff --line-uses-inside \
	     --keyhlcolor=d23c3dff --bshlcolor=d23c3dff --separatorcolor=00000000 \
	     --insidevercolor=fecf4dff --insidewrongcolor=d23c3dff \
	     --ringvercolor=ffffffff --ringwrongcolor=ffffffff --indpos="x+160:y+h-140" \
	     --radius=20 --veriftext="" --wrongtext="" \
	     --timepos="x+(w/2)-260:y+(h/2)-100" -k --timecolor=ffffffff --timestr="%H:%M" \
	     --timefont="Roboto" --timesize=72  \
	     --datecolor=ffffffff 
pkill -u $USER -USR2 dunst

# Revert compton's config changes.
# dbus-send --print-reply --dest=com.github.chjj.compton.${DISPLAY/:/_} / \
    #     com.github.chjj.compton.opts_set string:no_fading_openclose boolean:true
# dbus-send --print-reply --dest=com.github.chjj.compton.${DISPLAY/:/_} / \
    #     com.github.chjj.compton.opts_set string:unredir_if_possible boolean:true
