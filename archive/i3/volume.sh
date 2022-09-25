#!/bin/bash

statusLine=$(amixer get Master | tail -n 1)
status=$(echo "${statusLine}" | grep -wo "on")
volume=$(echo "${statusLine}" | awk -F ' ' '{print $5}' | tr -d '[]%')

if [[ "${status}" == "on" ]]; then
  if [[ "${volume}" -eq 0 ]]; then
    echo "MUTE"
  else
    if [[ "${volume}" -lt 33 ]]; then
      icon=""
    elif [[ "${volume}" -lt 66 ]]; then
      icon=""
    else
      icon=""
    fi
    echo "${icon} ${volume}%"
  fi
else
  echo "MUTE"
fi
