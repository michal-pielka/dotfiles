#!/usr/bin/env bash

geometry=$(slurp) || exit 0

grim -g "$geometry" - | wl-copy --type image/png
notify-send "Screenshot" "Selected area copied to clipboard"
