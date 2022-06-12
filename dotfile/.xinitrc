#!/bin/bash
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS="@im=fcitx"

FILE=/dev/input/by-id/usb-Topre_Corporation_HHKB_Professional-event-kbd
if [ -L "$FILE" ]; then
	setxkbmap -layout us -option
else 
	setxkbmap -layout us -option ctrl:swapcaps
fi

~/ohmyarch/script/wallpaper.sh &
~/ohmyarch/script/statusbar.sh &
picom --experimental-backends -b

# typing speed
xset r rate 266 26
# brightness minimum
brillo -c -S 1
/usr/bin/pactl load-module module-bluetooth-discover
exec sxhkd &
exec fcitx5 &
exec dwm
