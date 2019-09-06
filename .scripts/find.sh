#!/run/current-system/sw/bin/bash
IFS=':'

get_selection() {
    fd --no-ignore-vcs --type f -c never . | fzf --reverse --color pointer:3,info:14,bg+:-1
}

if selection=$( get_selection ); then
    nohup mimeo "$selection" >/dev/null 2>&1 &
    sleep 0.05
fi

echo -ne ' '
exit 0
