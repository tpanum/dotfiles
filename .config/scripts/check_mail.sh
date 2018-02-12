#!/run/current-system/sw/bin/sh
STATE=`/run/current-system/sw/bin/nmcli networking connectivity`
if [ $STATE = 'full' ]
then
    /run/current-system/sw/bin/mbsync -aq
    /run/current-system/sw/bin/notmuch new
    exit 0
fi
echo "No internet connection"
exit 0
