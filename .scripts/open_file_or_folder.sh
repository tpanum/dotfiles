#!/run/current-system/sw/bin/bash
st -t "Open file or folder" -c "fzf-menu" -e ~/.scripts/find.sh &
sleep 0.2
~/.scripts/center_window.sh 
