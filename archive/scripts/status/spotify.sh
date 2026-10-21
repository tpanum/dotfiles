#!/bin/sh

spotify_metadata=$(dbus-send --print-reply --session --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get string:'org.mpris.MediaPlayer2.Player' string:'Metadata' 2> /dev/null)
if [ $? -ne 0 ]; then
    echo ""
    exit 0
fi

title=$(echo "${spotify_metadata}" | grep title -A 1 | tail -n 1 | cut -f  2 -d '"')
artist=$(echo "${spotify_metadata}" | grep artist -A 2 | tail -n 1 | cut -f  2 -d '"')
echo "^c##1DB954^^d^  ${artist} - ${title}  •"
