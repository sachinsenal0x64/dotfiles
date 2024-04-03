#!/bin/sh

ffmpeg -nostats -loglevel 0 -f x11grab -video_size 1920x1080 -i :0 -f pulse -i alsa_output.pci-0000_00_1b.0.analog-stereo.monitor -r 60 -c:v libx264 -preset veryfast -b:v 10M -crf 23 -c:a aac ~/Videos/$(date +'%Y-%m-%d-%T')-record.mp4

