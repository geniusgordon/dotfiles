FG='#2f343f'
BG='#cce7e8eb'
HLFG='#e7e8eb'
HLBG='#cc2f343f'
SETTINGS=' Network Settings'
WIFI_LIST=$(\
  nmcli -f 'BARS,SSID' d wifi list | \
  tail -n +2 \
)
LINES=$(echo -e "$WIFI_LIST" | awk 'END {print NR}')
if [[ "$LINES" -gt 10 ]]; then
  LINES=10
fi
LINES=$((LINES+1))
WIFI=$(\
  echo -e "$SETTINGS\n$WIFI_LIST" | \
  rofi \
    -i \
    -dmenu \
    -location 3 \
    -width 16 \
    -lines $LINES \
    -columns 1 \
    -yoffset 32 \
    -xoffset -15 \
    -p wifi \
    -bw 0 \
    -font 'Lato 12' \
    -line-padding 4 \
    -padding 4 \
    -color-normal "#00ffffff,${FG},#00ffffff,${HLBG},${HLFG}" \
    -color-active "#00ffffff,${FG},#00ffffff,${HLBG},${HLFG}" \
    -color-window "${BG}"
)
if [[ "$WIFI" == "$SETTINGS" ]]; then
  gnome-control-center network
  exit 0
fi
WIFI=$(echo "$WIFI" | awk '{print $1}')
if [[ ${#WIFI} -gt 0 ]]; then
  nmcli c show "$WIFI"
  if [[ $? -eq 0 ]]; then
    nmcli c up "$WIFI"
  else
    nmcli d wifi connect "$WIFI"
  fi
fi
