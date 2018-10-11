#!/run/current-system/sw/bin/sh
msg=$(/run/current-system/sw/bin/cat -)

if [ "$1" = "ok" ]; then
    /run/current-system/sw/bin/notify-send -t 15000 --app-name="Backup" "Backup Finished" "$msg"
else
    /run/current-system/sw/bin/notify-send -t 15000 --app-name="Backup" --category="Failed" "Backup Failed" "Error occured when trying to perform backup"
fi
