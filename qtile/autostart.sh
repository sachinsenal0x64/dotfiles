#!/bin/sh

xrandr --newmode "1920x1080R_60.00"  138.50  1920 1968 2000 2080  1080 1083 1088 1111 +hsync -vsync && xrandr --addmode DP-1 "1920x1080R_60.00" && xrandr --output DP-1 --mode "1920x1080R_60.00"

picom &

~/dotfiles/scripts/wallpaper.sh

killall polybar

polybar -r mybar

setxkbmap us

playerctld daemon &
