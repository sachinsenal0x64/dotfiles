#!/bin/sh


UB_PID_FILE="/tmp/.$(uuidgen)"
ueberzugpp layer --no-stdin --silent --use-escape-codes --pid-file "$UB_PID_FILE"
UB_PID="$(cat "$UB_PID_FILE")"
export UB_SOCKET=/tmp/ueberzugpp-"$UB_PID".socket
ueberzugpp cmd -s "$UB_SOCKET" -a add -i PREVIEW -x "$1" -y "$2" --max-width "$3" --max-height "$4" -f "$5"
read -r
ueberzugpp cmd -s "$UB_SOCKET" -a exit
