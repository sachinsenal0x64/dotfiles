#!/bin/sh
# Save this as logout.sh and make it executable (chmod +x logout.sh)

# Send logout signal to the window manager
pkill -SIGTERM -f "qtile"

# Wait for a short duration to allow processes to clean up
sleep 2

# Kill any remaining processes owned by the user
pkill -u $USER

