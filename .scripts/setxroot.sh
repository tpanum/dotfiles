DATETIME=$(date "+%b %d • \x02%H:%M\x01")
VOLUME=$( amixer sget Master | grep -e 'Front Left:' | \
	      sed 's/[^\[]*\[\([0-9]\{1,3\}%\).*\(on\|off\).*/\2 \1/' | sed 's/off/M/' | sed 's/on //' )
# UNREADMAIL=`cat .unreadmail`
if [ `date +%S` == 30 -o `date +%S` == 00 ]; then python imap_check_unread.py > .unreadmail; fi

function battery_state(){
    raw_state=$(acpi -b | tail -n 1)
    icon=""
    if echo "${raw_state}" | grep -q "Discharging"; then
	icon='  '
    elif echo "${raw_state}" | grep -q "Charging"; then
	icon='  '
    fi

    state=$( acpi -b | tail -n 1 | awk '{ print $4 }' | tr -d ',' )

    echo -e "${state}${icon}"
}

bar=$(echo -ne "$(battery_state)  •  ${DATETIME}")
xsetroot -name "${bar}"
