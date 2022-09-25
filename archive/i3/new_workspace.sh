ws=$(i3-msg -t get_workspaces | jq '.[] | .num')
new_ws=1
for w in $ws
do
  if [[ $new_ws -eq $w ]]; then
    new_ws=$((new_ws + 1))
  else
    break
  fi
done
i3-msg "workspace $new_ws"
