#!/bin/bash

bat0=$(upower -i /org/freedesktop/UPower/devices/battery_BAT0)
bat1=$(upower -i /org/freedesktop/UPower/devices/battery_BAT1)
state=$(echo "$bat0" | grep state | awk '{print $2}')

p0=$(echo "$bat0" | grep percentage | awk '{print $2}')
p1=$(echo "$bat1" | grep percentage | awk '{print $2}')
p0=${p0/\%/}
p1=${p1/\%/}
total=$((p0+p1))

if [[ "$total" -lt 40 ]]; then
  icon=""
elif [[ "$total" -lt 80 ]]; then
  icon=""
elif [[ "$total" -lt 120 ]]; then
  icon=""
elif [[ "$total" -lt 160 ]]; then
  icon=""
else
  icon=""
fi

if [[ "${state}" == "charging" ]]; then
  icon=""
fi

echo ${icon} ${p0}% ${p1}%
