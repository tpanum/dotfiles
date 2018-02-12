#!/run/current-system/sw/bin/sh
function get_volume {
    amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

volume=`get_volume`
if [ "$volume" -gt "100" ]
then
   volume="100"
fi

if [ "$volume" -gt "0" ] && [ "$volume" -lt "50" ]
then
    icon=""
elif [ "$volume" -gt "49" ]
then
    icon=""
else
    icon=""
fi


bar=$(seq -s "─" $(($volume * 10 / 25)) | sed 's/[0-9]//g')
title="Volume"

pkill dunst
notify-send -t 200 "$title" "$bar" -i "$icon"
