BG='#ee2f343f'
FG='#e7e8eb'
HLBG='#e7e8eb'
HLFG='#2f343f'
POWER=" Log Out\n Lock\n Reboot\n Power Off"
ROFI=$(\
  echo -e $POWER | \
  rofi \
    -i \
    -dmenu \
    -location 3 \
    -width 12 \
    -lines 4 \
    -columns 1 \
    -yoffset 30 \
    -xoffset 1 \
    -p power \
    -font 'Operator Mono Book 12' \
    -line-padding 8 \
    -padding 8 \
    -color-normal "#00ffffff,${FG},#00ffffff,${HLBG},${HLFG}" \
    -color-active "#00ffffff,${FG},#00ffffff,${HLBG},${HLFG}" \
    -color-window "${BG}" | \
  awk '{print $2}'
)
if [ ${#ROFI} -gt 0 ]
then
  case $ROFI in
  Log)
    gnome-session-quit --force
    ;;
  Lock)
    ~/.config/i3/lock.sh && systemctl suspend
    ;;
  Power)
    systemctl poweroff
    ;;
  Reboot)
    systemctl reboot
    ;;
  esac
fi
