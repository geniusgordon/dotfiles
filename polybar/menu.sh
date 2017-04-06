FG='#242424'
BG='#fefefe'
HLFG='#242424'
HLBG='#eeeeee'
rofi \
  -show 'drun' \
  -lines 10 \
  -columns 3 \
  -location 1 \
  -width 36 \
  -yoffset 32 \
  -p power \
  -bw 0 \
  -font 'Lato 12' \
  -line-padding 4 \
  -padding 4 \
  -color-normal "#00ffffff,${FG},#00ffffff,${HLBG},${HLFG}" \
  -color-active "#00ffffff,${FG},#00ffffff,${HLBG},${HLFG}" \
  -color-window "${BG}"
