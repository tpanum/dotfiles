WALLPAPER_ABS=$(shuf -n1 -e ~/.wallpaper/mountain.jpg)
WALLPAPER_FILE=${WALLPAPER_ABS##*/}
WALLPAPER_BASE=${WALLPAPER_FILE%.*}
SCREEN_SIZE="3840x2160"
WALLPAPER_CACHE_FILE="/home/tpanum/.wallpaper/.cache/${WALLPAPER_BASE}_${SCREEN_SIZE}_with_logo.jpg"
WALLPAPER_CURRENT="/home/tpanum/.wallpaper/.cache/current"

if [ ! -f "$WALLPAPER_CACHE_FILE" ]; then
    mkdir -p ~/.wallpaper/.cache
    hsetroot -fill "$WALLPAPER_ABS" -tint '#2E3440' -write "$WALLPAPER_CACHE_FILE"
    convert $WALLPAPER_CACHE_FILE -geometry "${SCREEN_SIZE}^" -gravity center -crop "${SCREEN_SIZE}+0+0" $WALLPAPER_CACHE_FILE
    convert $WALLPAPER_CACHE_FILE ~/.wallpaper/logo/nixos-logo.png -gravity Center -geometry 400x400+0+0 -composite $WALLPAPER_CACHE_FILE
fi

rm "$WALLPAPER_CURRENT"
ln -s "$WALLPAPER_CACHE_FILE" "$WALLPAPER_CURRENT"

hsetroot -fill "$WALLPAPER_CACHE_FILE"
