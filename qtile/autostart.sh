#!/bin/sh


xrandr -s 1920x1080 --rate 60

picom &

~/dotfiles/scripts/wallpaper.sh

killall polybar

polybar -r mybar

setxkbmap us


