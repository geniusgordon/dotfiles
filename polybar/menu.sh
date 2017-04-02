BG='#ee2f343f'
FG='#e7e8eb'
HLBG='#e7e8eb'
HLFG='#2f343f'
rofi \
  -show 'drun' \
  -lines 10 \
  -columns 3 \
  -location 1 \
  -yoffset 30 \
  -p power \
  -font 'Operator Mono Book 12' \
  -line-padding 8 \
  -padding 8 \
  -color-normal "#00ffffff,${FG},#00ffffff,${HLBG},${HLFG}" \
  -color-active "#00ffffff,${FG},#00ffffff,${HLBG},${HLFG}" \
  -color-window "${BG}"
