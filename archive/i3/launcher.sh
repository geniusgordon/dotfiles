TYPE=${1:-drun}
rofi \
  -show $TYPE \
  -font 'Lato 16' \
  -lines 5 \
  -padding 12 \
  -line-padding 12 \
  -separator-style 'none' \
  -hide-scrollbar \
  -color-normal '#00ffffff,#525d76,#00ffffff,#525d76,#e7e8eb' \
  -color-urgent '#00ffffff,#525d76,#00ffffff,#525d76,#e7e8eb' \
  -color-active '#00ffffff,#525d76,#00ffffff,#525d76,#e7e8eb' \
  -color-window '#ddffffff, #ddfffffff'
  #              bg        fg      bgalt     hlbg    hlfg
  #              background border      separator
