#!/run/current-system/sw/bin/bash

exists() {
    while IFS= read -r f; do
	test -e "$f" && echo "$f"
    done
}

detach() {
    setsid "$@" &>/dev/null
    # "$@" 1>/dev/null 2>/dev/null & disown
    # sleep 5
}

prog=$(ls -1 $(echo $PATH | tr ':' '\n' | exists) |
	   awk 'NF' |
	   grep -v ':' |
	   sort -u |
	   awk '{print $1}' |
	   fzf --reverse --color pointer:1,fg+:1,hl:1,info:14,fg:8,bg+:-1 --prompt "Application")

[ -z $prog ] && exit 1

detach sh -c "$prog && echo $prog" &

# get_selection() {
#     compgen -c | sort -u | fzf --reverse --color pointer:1,fg+:1,hl:1,info:14,fg:8,bg+:-1 --prompt "Application: "
# }

# if selection=$( get_selection ); then
#     (nohup $selection >/dev/null 2>&1 &)
#     sleep 0.1
# fi

# echo -ne ' '
# exit 0
