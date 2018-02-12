#PUT THIS FILE IN ~/.local/share/rofi/finder.sh
#USE: rofi  -show find -modi find:~/.local/share/rofi/finder.sh
if [ ! -z "$@" ]
then
    QUERY=$(echo "$@" | sed -e "s|^~|$HOME|g")
    if [[ "$QUERY" == /* ]]
    then
        coproc ( rifle "$QUERY"  > /dev/null 2>&1 )
        exec 1>&-
        exit;
    else
        rg --files ~ -g "*${QUERY}*" | sed -e "s|^$HOME|~|g"
    fi
else
    echo "type to search $HOME"
fi
