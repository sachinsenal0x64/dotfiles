connected="∙󰒢"
disconnected="∙󰞃"

while true; do
    if ping -c 1 8.8.8.8 &>/dev/null; then
       echo -e "%{F#32a883}$connected Online" ; sleep 25
    else
       echo -e "%{F#bf4741}$disconnected Offline" ; sleep 5
    fi
done

