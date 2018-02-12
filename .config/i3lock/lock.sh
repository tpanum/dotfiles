overlay=/home/tpanum/nixos_logo.png

# scrot /tmp/currentworkspace.png
# convert /tmp/currentworkspace.png -blur 0x5 /tmp/currentworkspaceblur.png
# composite -gravity center $overlay /tmp/currentworkspaceblur.png /tmp/lockbackground.png
# i3lock -i /tmp/lockbackground.png

image_file=/tmp/screen_lock.png
resolution=$(xrandr | grep -E "[0-9]+x[0-9]+[ ]+[0-9]+\.[0-9]+\*" | awk '{print $1}')
filters='gblur=sigma=20'
ffmpeg -y -loglevel 0 -s "$resolution" -f x11grab -i $DISPLAY -vframes 1 \
       -vf "$filters" "$image_file"
composite -gravity center $overlay "$image_file" "$image_file"
i3lock -e -i "$image_file"
