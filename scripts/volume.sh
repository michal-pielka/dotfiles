#!/usr/bin/env bash

SPEAKER_ICON='
⢠⠶⠞⠿⠝⠓⠋⠛⠙⠉⠉⣟⠀⠀⠀⠀
⠨⡃⠀⠀⠀⠀⠀⠀⠀⠀⠀⣛⠀⠀⠀⠀
⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⡆⠀⠀⠀⠀
⠀⡅⡀⣀⡀⠀⠀⠀⠀⠀⠀⣇⠤⣄⠀⠀
⠀⡟⣟⣝⢗⠀⠀⠀⠀⠀⢰⣗⣩⣭⡆⠀
⠀⣟⣀⣙⣿⠀⠀⠀⠀⠀⠀⠙⠮⠾⠧⠃
⠀⠀⠉⠁⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
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

is_muted() {
  wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q "MUTED"
}


case "$1" in
  up)
    is_muted && wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
    ;;
  down)
    is_muted && wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    ;;
  mute)
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    ;;
esac

status="$(wpctl get-volume @DEFAULT_AUDIO_SINK@)"
vol_int=$(LC_NUMERIC=C awk '{printf("%d\n", $2*100+0.5)}' <<< "$status")

if grep -q "MUTED" <<< "$status"; then
  bar="$(build_bar 0)"
else
  bar="$(build_bar "$vol_int")"
fi

notify-send \
  --app-name="media-osd" \
  --expire-time=600 \
  --print-id \
  -h boolean:transient:true \
  -h string:x-canonical-private-synchronous:osd \
  "$SPEAKER_ICON$bar"
