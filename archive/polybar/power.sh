FG='#242424'
BG='#fefefe'
HLFG='#242424'
HLBG='#eeeeee'
POWER="   Lock\n   Log Out\n   Reboot\n   Power Off"
ROFI=$(\
  echo -e "$POWER" | \
  rofi \
    -i \
    -dmenu \
    -location 3 \
    -width 12 \
    -lines 4 \
    -columns 1 \
    -yoffset 32 \
    -xoffset -5 \
    -p power \
    -bw 0 \
    -font 'Lato 12' \
    -line-padding 4 \
    -padding 4 \
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
