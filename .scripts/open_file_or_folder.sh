#!/run/current-system/sw/bin/bash
WINIT_HIDPI_FACTOR=1 alacritty --title "Open file or folder" --class "fzf-menu" -e ~/.scripts/find.sh &
sleep 0.2
~/.scripts/center_window.sh 
