#!/bin/sh


output="$HOME/Pictures/$(date +'%Y-%m-%d-%T')-screenshot.png"


scrot "$output" --focused --border

