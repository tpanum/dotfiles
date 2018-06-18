#!/run/current-system/sw/bin/sh
msg=$(/run/current-system/sw/bin/cat -)

/run/current-system/sw/bin/notify-send -t 15000 " Backup" "$msg"
