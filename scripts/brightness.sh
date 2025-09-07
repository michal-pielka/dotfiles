

#!/usr/bin/env bash

get_ascii_art() {
    local brightness_int="$1"

    local empty_char="⠀"
    local fill_char="⠿"
    local bar=""

    # build bar
    for (( i = 1; i <= 20; i++ )); do
        if (( i * 5 <= brightness_int )); then
            bar+="$fill_char"
        else
            bar+="$empty_char"
        fi
    done

    # print brightness icon + bar on last line
	local brightness_icon="⠀⠀⠀⠀⠀⠀⠀⠀⢠⡄⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠠⣄⠀⠀⠸⠇⠀⠀⣠⠄⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠈⢁⣤⠶⠶⣤⡈⠁⠀⠀⠀⠀⠀
⠀⠀⠀⣤⣤⠀⣾⠁⠀⠀⠈⣷⠀⣤⣤⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠹⣦⣀⣀⣴⠏⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢀⡴⠂⠀⢉⡉⠀⠐⢦⡀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⢸⡇⠀⠀⠀⠀⠀⠀⠀⠀

"
	echo "$brightness_icon$bar"
}

case "$1" in
    up)
		brightnessctl set 5%+
        ;;
    down)
		brightnessctl set 5%-
        ;;
esac

# Convert float to int
brightness_int=$(brightnessctl g --percentage)
echo brightness_int
echo $brightness_int
ascii_art=$(get_ascii_art "$brightness_int")

# Keep the last notification id so we can replace it
idfile="${XDG_RUNTIME_DIR:-/tmp}/brightness_notify_id"
prev_id=""
[[ -f "$idfile" ]] && prev_id="$(<"$idfile")"

# Build optional replace args if we have a previous id
replace_args=()
[[ -n "$prev_id" ]] && replace_args+=(--replace-id="$prev_id")

# Send/update the notification in place
nid=$(
  notify-send \
    --app-name="brightness_script" \
    --expire-time=600 \
    --print-id \
    -h boolean:transient:true \
    "${replace_args[@]}" \
    "$ascii_art"
)

# Store the id for next time
[[ -n "$nid" ]] && printf '%s' "$nid" >"$idfile"
