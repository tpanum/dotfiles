#!/run/current-system/sw/bin/bash
REPO=backup:/data/backup/tpanum/home
if /run/current-system/sw/bin/pidof -x borg > /dev/null; then
    echo "Backup already running."
    exit
fi

BORG_RELOCATED_REPO_ACCESS_IS_OK=yes \
BORG_PASSPHRASE='b4ckupopenup'       \
/run/current-system/sw/bin/borg create   \
--filter AME                        \
--stats                             \
--json                              \
--show-rc                           \
--progress                          \
--compression lz4                   \
--exclude-caches                    \
--exclude '/home/*/.cache/*'        \
--exclude '*.ova'                   \
--exclude 'VirtualBox VMs'          \
$REPO::'{hostname}-{now:%Y-%m-%d.%H:%M:%S}' \
$HOME | /home/tpanum/.scripts/backup_summary.py "Home Server" | /home/tpanum/.notifications/backup.sh

BORG_PASSPHRASE='b4ckupopenup'                        \
/run/current-system/sw/bin/borg prune                     \
--list                                               \
--prefix '{hostname}-'                               \
--show-rc                                            \
--keep-daily    2                                    \
--keep-weekly   5                                    \
--keep-monthly  4                                    \
$REPO
