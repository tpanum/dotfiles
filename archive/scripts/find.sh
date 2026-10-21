#!/run/current-system/sw/bin/bash
IFS=':'

get_selection() {
    { fzf --reverse --color pointer:3,fg+:3,fg:8,info:14,bg+:-1 --prompt "File: "; if [ $(ps -p "$!" > /dev/null) ]; then kill "$!"; fi } < <(fd --no-ignore-vcs --type f -c never .)
}

if selection=$( get_selection ); then
    nohup mimeo "$selection" >/dev/null 2>&1
    sleep 0.1
fi

exit 0
