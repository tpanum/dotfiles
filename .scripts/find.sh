#!/run/current-system/sw/bin/bash
IFS=':'

get_selection() {
    find ~ -type d ! -readable -prune -o -print | fzf --reverse 
}

if selection=$( get_selection ); then
    nohup mimeo "$selection" >/dev/null 2>&1 &
    sleep 0.05
fi

