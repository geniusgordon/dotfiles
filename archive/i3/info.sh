date=$(date +"%Y-%m-%d      %H:%M")
volume=$(~/.config/i3/volume.sh)
battery=$(~/.config/i3/battery.sh)
notify-send -i person "$date" "\n$volume\t$battery"
