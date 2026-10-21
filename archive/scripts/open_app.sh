#!/run/current-system/sw/bin/bash
compgen -c | sort -u |  fzf --reverse --color pointer:3,info:14,bg+:-1 | xargs -r swaymsg -t command exec
