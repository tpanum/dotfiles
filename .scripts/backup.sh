#!/run/current-system/sw/bin/bash
REPO=backup:/data/backup/tpanum/home
BORG_PASSPHRASE='b4ckupopenup'
if /run/current-system/sw/bin/pidof -x borg > /dev/null; then
    echo "Backup already running."
    exit
fi

JSON_OUTPUT=$(./make_backup.sh "$REPO" "$BORG_PASSPHRASE")
rc=$?; if [[ $rc -gt 1 ]]; then echo "" | $HOME/.notifications/backup.sh "failed"; exit $rc; fi


BORG_PASSPHRASE='b4ckupopenup'\
	       /run/current-system/sw/bin/borg prune                     \
	       --list                                               \
	       --prefix '{hostname}-'                               \
	       --show-rc                                            \
	       --keep-daily    2                                    \
	       --keep-weekly   5                                    \
	       --keep-monthly  4                                    \
	       $REPO


TOTAL_SIZE=$(BORG_PASSPHRASE='b4ckupopenup' borg info $REPO | grep -A 1 "Deduplicated size" | head -n2 | tail -n1 | awk '{ print $7, $8 }')

SUMMARY=$(echo "$JSON_OUTPUT" | /home/tpanum/.scripts/backup_summary.py "Home Server")
echo "$SUMMARY\nTotal size: $TOTAL_SIZE" | $HOME/.notifications/backup.sh "ok"
