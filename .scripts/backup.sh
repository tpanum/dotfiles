#!/run/current-system/sw/bin/sh
ONLINE_REPO="root@bactr.com:/root/backup"
ONLINE_REPO_OUT="/home/tpanum/external/online_backup"

export BORG_PASSPHRASE='b4ckupopenup'

py_formatter="""
def humanize_bytes(bytesize, precision=0):
    abbrevs = (
        (1<<50, 'PB'),
        (1<<40, 'TB'),
        (1<<30, 'GB'),
        (1<<20, 'MB'),
        (1<<10, 'kB'),
        (1, 'bytes')
    )
    if bytesize == 1:
        return '1 byte'
    for factor, suffix in abbrevs:
        if bytesize >= factor:
            break
    return '%.*f%s' % (precision, bytesize / factor, suffix)

def secToTime(s):
    m, s = divmod(s, 60)
    if m <= 0:
        return '{0:.0f}s'.format(s)

    return '{0:.0f}m {1:.0f}s'.format(m, s)

import sys
output=sys.stdin.read()

import json
j=json.loads(output)
s=humanize_bytes(j['archive']['stats']['deduplicated_size'])
t=secToTime(j['archive']['duration'])
print(t + ', +' + s)
"""

function local_backup() {
    local repo=/mnt/network/backup/borg

    /run/current-system/sw/bin/borg create                          \
         --filter AME                    \
         --stats                         \
         --json                          \
         --show-rc                       \
         --progress                      \
         --compression lz4               \
         --exclude-caches                \
         --exclude '/home/*/.cache/*'    \
         --exclude '*.ova'               \
         /mnt/network/backup/borg::{hostname}-{user}-{now:%Y-%m-%dT%H:%M:%S} \
         /home/tpanum

    local backup_exit=$?


    /run/current-system/sw/bin/borg prune                          \
         --list                          \
         --prefix '{hostname}-'          \
         --show-rc                       \
         --keep-daily    6               \
         --keep-weekly   5               \
         --keep-monthly  3               \
         /mnt/network/backup/borg > /dev/null

    local prune_exit=$?

    global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

    return ${global_exit}
}

status_msg=""

# if [ "$can_do_local_backup" -eq "yes" ]; then
#     raw_stats=$(local_backup)
#     backup_exit=$?

#     if [ ${backup_exit} -gt 0 ];
#     then
#         status_msg="${status_msg} Local backup (!!)"
#     else
#         stats=$(echo "$raw_stats" | /run/current-system/sw/bin/python -c "$py_formatter")
#         status_msg="${status_msg} Local backup (${stats})"
#     fi

#     status_msg="${status_msg}\n"
# fi

function online_backup() {
    sshfs -oIdentityFile=/home/tpanum/id_backup $ONLINE_REPO "$ONLINE_REPO_OUT" > /dev/null

    /run/current-system/sw/bin/borg create                          \
         --filter AME                    \
         --stats                         \
         --json                          \
         --show-rc                       \
         --progress                      \
         --compression auto,zlib,4       \
         --exclude-caches                \
         --exclude '/home/*/.cache/*'    \
         --exclude '*.ova'               \
         $ONLINE_REPO_OUT::{hostname}-{user}-{now:%Y-%m-%dT%H:%M:%S} \
         /home/tpanum/research

    local backup_exit=$?

    /run/current-system/sw/bin/borg prune                          \
         --list                          \
         --prefix '{hostname}-'          \
         --show-rc                       \
         --keep-daily    2               \
         --keep-weekly   3               \
         --keep-monthly  2               \
         $ONLINE_REPO_OUT > /dev/null

    local prune_exit=$?

    global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

    fusermount -u $ONLINE_REPO_OUT

    return ${global_exit}
}

function gdrive_backup() {
    /run/current-system/sw/bin/borg create                          \
         --filter AME                    \
         --stats                         \
         --json                          \
         --show-rc                       \
         --progress                      \
         --compression auto,zlib,4       \
         --exclude-caches                \
         --exclude '/home/*/.cache/*'    \
         --exclude '*.ova'               \
         /mnt/network/gdrive/Backup/Borg::{hostname}-{user}-{now:%Y-%m-%dT%H:%M:%S} \
         /home/tpanum/research

    local backup_exit=$?


    /run/current-system/sw/bin/borg prune                          \
         --list                          \
         --prefix '{hostname}-'          \
         --show-rc                       \
         --keep-daily    2               \
         --keep-weekly   3               \
         --keep-monthly  2               \
         /mnt/network/gdrive/Backup/Borg > /dev/null

    local prune_exit=$?

    global_exit=$(( backup_exit > prune_exit ? backup_exit : prune_exit ))

    return ${global_exit}
}

# if [ "$can_do_gdrive_backup" -eq "yes" ]; then
#     raw_stats=$(gdrive_backup)
#     backup_exit=$?

#     if [ ${backup_exit} -gt 0 ];
#     then
#         status_msg="${status_msg} Gdrive backup (!!)"
#     else
#         stats=$(echo "$raw_stats" | /run/current-system/sw/bin/python -c "$py_formatter")
#         status_msg="${status_msg} Gdrive backup (${stats})"
#     fi
# fi

# raw_stats=$(local_backup)
# backup_exit=$?
# if [ ${backup_exit} -gt 0 ];
# then
#     status_msg="${status_msg} Local backup (!!)"
# else
#     stats=$(echo "$raw_stats" | /run/current-system/sw/bin/python -c "$py_formatter")
#     status_msg="${status_msg} Local backup (${stats})"
# fi

status_msg="${status_msg}\n"

raw_stats=$(online_backup)
backup_exit=$?
if [ ${backup_exit} -gt 0 ];
then
    status_msg="${status_msg} Online backup (!!)"
else
    stats=$(echo "$raw_stats" | /run/current-system/sw/bin/python -c "$py_formatter")
    status_msg="${status_msg} Online backup (${stats})"
fi


/run/current-system/sw/bin/notify-send -t 15000 " Backup Completed" "${status_msg}"
