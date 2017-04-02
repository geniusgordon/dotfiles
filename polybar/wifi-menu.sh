BG='#ee2f343f'
FG='#e7e8eb'
HLBG='#e7e8eb'
HLFG='#2f343f'
SETTINGS=' Network Settings'
WIFI_LIST=$(nmcli d wifi list | tail -n +2 | awk '$1 == "*" {print $2, $8}; $1 != "*" {print $1, $7}')
WIFI=$(\
  echo -e "$SETTINGS\n$WIFI_LIST" | \
  rofi \
    -i \
    -dmenu \
    -location 3 \
    -width 15 \
    -lines 10 \
    -columns 1 \
    -yoffset 30 \
    -xoffset 1 \
    -p wifi \
    -font 'Operator Mono Book 12' \
    -line-padding 8 \
    -padding 8 \
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
