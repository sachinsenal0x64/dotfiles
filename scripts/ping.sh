#!/bin/sh

connected="󰒢 "
disconnected="󰞃 "

while true; do
    if ping -c 1 8.8.8.8 &>/dev/null; then
       echo "%{F#32a883}$connected" ; sleep 25
    else
       echo "%{F#bf4741}$disconnected" ; sleep 5
    fi
done

