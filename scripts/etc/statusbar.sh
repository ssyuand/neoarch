#!/bin/bash
# Network speed stuff stolen from http://linuxclues.blogspot.sg/2009/11/shell-script-show-network-speed.html

print_wifi() {
	ip=$(ip route get 8.8.8.8 2>/dev/null | grep -Eo 'src [0-9.]+' | grep -Eo '[0-9.]+')
	echo -e "[ $ip ]"
}

battery="BAT0"

has_battery() {
	if [ -d /sys/class/power_supply/$battery ]; then
		return 0
	fi
	return 1
}
get_battery_status() {
	charge="$(get_charge)"
	charge_st="$(get_charging_status)"
	Charging="⚡"
	no_Charging=""
	if [[ $charge_st == "Charging" ]]; then
		echo ""$charge"% "$Charging""
	else
		echo ""$no_Charging" "$charge"%"

	fi
}

get_charging_status() {
	cat "/sys/class/power_supply/$battery/status"
}

get_charge() {
	cat "/sys/class/power_supply/$battery/capacity"
}

get_status() {
	battery_status=""
	if $(has_battery); then
		battery_status=" $(get_battery_status)"
	fi

	echo "${battery_status}"
}

print_date() {
	date +" %a %d %b %Y |  %I:%M:%S %p %Z"
}

xst=`echo $DISPLAY`
if [[ $xst != "" ]]; then
while true; do
	xsetroot -name "$(print_wifi) $(print_date) |$(get_status) "
done
fi
