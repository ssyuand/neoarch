#!/bin/bash
export GTK_IM_MODULE=fcitx5
export QT_IM_MODULE=fcitx5
export XMODIFIERS="@im=fcitx5"
export _JAVA_AWT_WM_NONREPARENTING=1

FILE=/dev/input/by-id/usb-Topre_Corporation_HHKB_Professional-event-kbd
if [ -L "$FILE" ]; then
	setxkbmap -layout us -option
else 
	setxkbmap -layout us -option ctrl:swapcaps
        setxkbmap -option altwin:swap_lalt_lwin
        setxkbmap -option ctrl:swap_rctrl_lwin

fi

~/neoarch/scripts/etc/wallpaper.sh &
~/neoarch/scripts/etc/statusbar.sh &
picom --experimental-backends -b

# typing speed
xset r rate 266 26
# brightness minimum
brillo -c 1
/usr/bin/pactl load-module module-bluetooth-discover
feh --bg-fill ~/Desktop/wallpaper/wp.jpg
exec sxhkd &
exec fcitx5 &
exec dwm
