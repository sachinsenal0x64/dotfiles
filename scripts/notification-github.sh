#!/bin/sh

QTILE_SCRIPTS_DIR="$HOME/Documents"
USER="sachinsenal0x64"
TOKEN=$(grep -oP 'github-access-token=\K.*' "${QTILE_SCRIPTS_DIR}/key.conf")

notifications=$(echo "user=\"$USER:$TOKEN\"" | curl -sf -K- https://api.github.com/notifications | jq ".[].unread" | grep -c true)

if [ "$notifications" -gt 0 ]; then
    echo "$notifications"
else
    echo "$notifications"
fi
