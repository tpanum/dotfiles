#!/run/current-system/sw/bin/bash

WALLPAPER_ABS=$(shuf -n1 -e ~/.wallpaper/*)
WALLPAPER_FILE=${WALLPAPER_ABS##*/}
WALLPAPER_BASE=${WALLPAPER_FILE%.*}
WALLPAPER_CACHE_FILE="/home/tpanum/.wallpaper/.cache/${WALLPAPER_BASE}_with_logo.jpg"
WALLPAPER_CURRENT="/home/tpanum/.wallpaper/.cache/current"

if [ ! -f "$WALLPAPER_CACHE_FILE" ]; then
    mkdir -p ~/.wallpaper/.cache
    hsetroot -fill "$WALLPAPER_ABS" -tint '#3c6f86' -write "$WALLPAPER_CACHE_FILE"
    convert $WALLPAPER_CACHE_FILE ~/.wallpaper/logo/nixos-logo.png -gravity SouthEast -geometry 200x200+100+70 -composite $WALLPAPER_CACHE_FILE
fi

ln -s "$WALLPAPER_CACHE_FILE" "$WALLPAPER_CURRENT"

hsetroot -fill "$WALLPAPER_CACHE_FILE"
