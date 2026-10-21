#!/run/current-system/sw/bin/bash
joint_info=$(paste /sys/class/power_supply/BAT0/uevent /sys/class/power_supply/BAT1/uevent | awk '{split($0,a,"="); split(a[2],b," "); (a[3] == "Charging" || b[1] == "Charging") ? $5 = "Charging" : $5 = (a[3] + b[1])/2; print a[1] "=" $5}')

icon=""
if echo "${joint_info}" | grep -q "STATUS=Charging"; then
    icon=""
else
    icon=""
fi

capacity=$(echo "${joint_info}" | grep "POWER_SUPPLY_CAPACITY=" |  cut -d "=" -f2)

echo "${icon}  ${capacity}%  •"
