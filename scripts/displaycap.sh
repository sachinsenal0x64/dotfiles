#!/bin/sh

if [ "$1" = "activewindow" ]; then
	# Get active window geometry
	eval $(xdotool getactivewindow getwindowgeometry --shell)
	REGION="${WIDTH}x${HEIGHT}+${X}+${Y}"
elif [ "$1" = "selectwindow" ]; then
	# Let the user select a window and get its geometry
	eval $(xdotool selectwindow getwindowgeometry --shell)
	REGION="${WIDTH}x${HEIGHT}+${X}+${Y}"
else
	# Get current screen
	SCREEN=$(xdotool get_desktop)
	REGION="screen${SCREEN}"
fi

# Launch the screenshot gui
flameshot gui --region "$REGION" --path "Pictures"  --clipboard
