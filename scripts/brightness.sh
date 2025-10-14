#!/usr/bin/env bash

icon='⠀⠀⠀⠀⠀⠀⠀⠀⢠⡄⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠠⣄⠀⠀⠸⠇⠀⠀⣠⠄⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠈⢁⣤⠶⠶⣤⡈⠁⠀⠀⠀⠀⠀
⠀⠀⠀⣤⣤⠀⣾⠁⠀⠀⠈⣷⠀⣤⣤⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠹⣦⣀⣀⣴⠏⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢀⡴⠂⠀⢉⡉⠀⠐⢦⡀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀

'

# Build a 20-char bar from an integer percent (0–100)
build_bar() {
  local percent="$1"
  local bar=""
  local fill="⠿"
  local empty="⠀"

  for (( i=1; i<=20; i++ )); do
    if (( i * 5 <= percent )); then
      bar+="$fill"
    else
      bar+="$empty"
    fi
  done

  printf '%s' "$bar"
}

case "$1" in
  up)   brightnessctl set 5%+ ;;
  down) brightnessctl set 5%- ;;
esac

cur=$(brightnessctl g)
max=$(brightnessctl m)
if (( max > 0 )); then
  bri_int=$(( (cur * 100 + max / 2) / max ))
else
  bri_int=0
fi

bar="$(build_bar "$bri_int")"

notify-send \
  --app-name="media-osd" \
  --expire-time=600 \
  --print-id \
  -h boolean:transient:true \
  -h string:x-canonical-private-synchronous:osd \
  "$icon$bar"
