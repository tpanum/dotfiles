#!/run/current-system/sw/bin/bash

PREFIX="${HOME}/.password-store"

function path2entry() {
    local v=$1
    v=${v#$PREFIX/}
    v=${v%.gpg}
    echo -n "$v"
}

function candidate_selector_fzf() {
    candidates=$1
    echo "$candidates" | fzf --select-1 --reverse --color pointer:1,fg+:1,hl:1,info:14,fg:8,bg+:-1
}

function list_entries() {
    find "$PREFIX" -name '*.gpg' | while read -r c; do
	echo $(path2entry "$c");
    done
}

candidates=$(list_entries)
res=$(candidate_selector_fzf "$candidates")
if [ -n "$res" ]; then
    old_clip=$(xclip -out -selection clipboard || echo "")
    # nohup $(sleep 10 && echo "${old_clip}" | xclip -selection c) >/dev/null 2>&1 &
    # xclip -out -selection clipboard
    pass "$res"
    # pass "$res" | xclip -selection clipboard
    echo -n "Hello" | xclip -selection CLIPBOARD
    # xclip -out -selection clipboard
    sleep 2
else
    exit 1
fi
