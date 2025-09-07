#!/usr/bin/env bash

get_ascii_art() {
    local volume_int="$1"

    local empty_char="⠐"
    local fill_char="⠿"
    local bar=""

    # build bar
    for (( i = 1; i <= 20; i++ )); do
        if (( i * 5 <= volume_int )); then
            bar+="$fill_char"
        else
            bar+="$empty_char"
        fi
    done
    # print speaker + bar on last line
	local speaker="
⢠⠶⠞⠿⠝⠓⠋⠛⠙⠉⠉⣟⠀⠀⠀⠀
⠨⡃⠀⠀⠀⠀⠀⠀⠀⠀⠀⣛⠀⠀⠀⠀
⠀⡇⠀⠀⠀⠀⠀⠀⠀⠀⠀⡆⠀⠀⠀⠀
⠀⡅⡀⣀⡀⠀⠀⠀⠀⠀⠀⣇⠤⣄⠀⠀
⠀⡟⣟⣝⢗⠀⠀⠀⠀⠀⢰⣗⣩⣭⡆⠀
⠀⣟⣀⣙⣿⠀⠀⠀⠀⠀⠀⠙⠮⠾⠧⠃
⠀⠀⠉⠁⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
"
	echo "$speaker$bar"
}

case "$1" in
    up)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
        ;;
    down)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
        ;;
    mute)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        ;;
esac

# Convert float to int
volume_int=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf("%d\n", $2*100+0.5)}')
ascii_art=$(get_ascii_art "$volume_int")

# Keep the last notification id so we can replace it
idfile="${XDG_RUNTIME_DIR:-/tmp}/volume_notify_id"
prev_id=""
[[ -f "$idfile" ]] && prev_id="$(<"$idfile")"

# Build optional replace args if we have a previous id
replace_args=()
[[ -n "$prev_id" ]] && replace_args+=(--replace-id="$prev_id")

# Send/update the notification in place
nid=$(
  notify-send \
    --app-name="volume_script" \
    --expire-time=600 \
    --print-id \
    -h boolean:transient:true \
    "${replace_args[@]}" \
    "$ascii_art"
)

# Store the id for next time
[[ -n "$nid" ]] && printf '%s' "$nid" >"$idfile"
