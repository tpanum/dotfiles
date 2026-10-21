#!/run/current-system/sw/bin/bash
export PATH="$PATH:/run/current-system/sw/bin"

if /run/current-system/sw/bin/pidof -x borg > /dev/null; then
    echo "Backup already running."
    exit
fi

function human_time() {
    local seconds=$1
    if ((seconds < 0)); then
        ((seconds *= -1))
    fi

    local times=(
	$((seconds / 60 / 60 / 24 / 365)) # years
	$((seconds / 60 / 60 / 24 / 30))  # months
	$((seconds / 60 / 60 / 24 / 7))   # weeks
	$((seconds / 60 / 60 / 24))       # days
	$((seconds / 60 / 60))            # hours
	$((seconds / 60))                 # minutes
	$((seconds))                      # seconds
    )
    local names=(y mo w d h m s)

    local i
    for ((i = 0; i < ${#names[@]}; i++)); do
        if ((${times[$i]} > 1)); then
            echo "${times[$i]}${names[$i]}"
            return
        elif ((${times[$i]} == 1)); then
            echo "${times[$i]}${names[$i]}"
            return
        fi
    done
    echo '0s'
}

function get_duration_seconds() {
    seconds=$(echo "$1" | jq .duration | cut -f 1 -d '.')
    human_time "$seconds"
}

function get_added_size() {
    echo "$1" | jq '.size_added' | numfmt --to=iec-i --suffix=B --format="%.1f"
}

function get_total_size() {
    echo "$1" | jq '.total_size' | numfmt --to=iec-i --suffix=B --format="%.1f"
}

function get_summary() {
    seconds=$(get_duration_seconds "$1")
    size_added=$(get_added_size "$1")
    size_total=$(get_total_size "$1")

    echo "Success! +${size_added} (${seconds})\nTotal Size: ${size_total}"
}


function notification_failed() {
    notify-send -t 15000 --app-name="Backup" --category="Failed" "Backup Failed" "Error occured when trying to perform backup"
}

function notification_ok() {
    summary=$(get_summary "$1")
    notify-send -t 15000 --app-name="Backup" "Backup Finished" "$summary"
}

function perform_backup() {
    REPO=/storage/backup/tpanum
    HOME=/home/tpanum
    export BORG_PASSPHRASE=$(cat /home/tpanum/.secret/borg_pass.txt)
    BORG_RELOCATED_REPO_ACCESS_IS_OK=yes

    coutput=$(borg create   \
	    --verbose \
	    --filter AME                        \
	    --stats                             \
	    --json                              \
	    --show-rc                           \
	    --progress                          \
	    --compression lz4                   \
	    --exclude-caches                    \
	    --exclude '/home/*/.local/*'        \
	    --exclude '/home/*/.*'              \
	    --exclude '*.ova'                   \
	    --exclude '*VirtualBox VMs*'        \
	    --exclude '/home/*/.cache/*'        \
	    -p \
	    "$REPO"::'{hostname}-{now:%Y-%m-%d.%H:%M:%S}' \
	    $HOME)

    rc=$?; if [[ $rc -gt 1 ]]; then exit $rc; fi

    borg prune                   \
	 --list                  \
	 --prefix '{hostname}-'  \
	 --show-rc               \
	 --keep-daily    4       \
	 --keep-weekly   7       \
	 --keep-monthly  8       \
	 $REPO

    ioutput=$(borg info --json $REPO)

    echo "${coutput}${ioutput}" | jq -s add | jq --compact-output '{ "duration": .archive.duration, "total_size": .cache.stats.unique_size, "size_added": .archive.stats.deduplicated_size}'
}


output=$(perform_backup)
if [[ $? -gt 1 ]]; then
    notification_failed
    exit $rc
fi

notification_ok "$output"
