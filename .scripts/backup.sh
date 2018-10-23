#!/run/current-system/sw/bin/bash
export PATH="$PATH:/run/current-system/sw/bin"
REPO=backup:/data/backup/tpanum/home
HOME=/home/tpanum
PASSNAME="personal/backup"
export BORG_PASSPHRASE=$(pass "$PASSNAME")

if /run/current-system/sw/bin/pidof -x borg > /dev/null; then
    echo "Backup already running."
    exit
fi

JSON_OUTPUT=$($HOME/.scripts/make_backup.sh "$REPO" "$BORG_PASSPHRASE")
rc=$?; if [[ $rc -gt 1 ]]; then echo "" | $HOME/.notifications/backup.sh "failed"; exit $rc; fi


BORG_PASSPHRASE="$BORG_PASSPHRASE" \
	       borg prune                     \
	       --list                                               \
	       --prefix '{hostname}-'                               \
	       --show-rc                                            \
	       --keep-daily    4                                    \
	       --keep-weekly   7                                    \
	       --keep-monthly  8                                    \
	       $REPO


TOTAL_SIZE=$(borg info $REPO | grep -A 1 "Deduplicated size" | head -n2 | tail -n1 | awk '{ print $7, $8 }')

SUMMARY=$(echo "$JSON_OUTPUT" | /home/tpanum/.scripts/backup_summary.py "Home Server")
echo "$SUMMARY\nTotal size: $TOTAL_SIZE" | $HOME/.notifications/backup.sh "ok"
