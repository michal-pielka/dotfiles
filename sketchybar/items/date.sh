#!/bin/sh

PLUGIN_DIR="$HOME/.config/sketchybar/plugins"

sketchybar --add item date right                        \
           --set      date script="$PLUGIN_DIR/date.sh" \
                           update_freq=60               \
                           padding_left=8               \
                           icon=$ICON_CALENDAR          \
