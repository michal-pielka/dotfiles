#!/bin/sh

PLUGIN_DIR="$HOME/.config/sketchybar/plugins"

sketchybar --add item time right                        \
           --set      time script="$PLUGIN_DIR/time.sh" \
                           update_freq=10               \
                           background.color=$COLOR_WHITE_BRIGHT_TRANSP  \
                           background.border_width=0    \
                           background.corner_radius=5         \
                           background.height=16               \
                           padding_right=8              \
                           icon=$ICON_CLOCK             \
                           icon.highlight=on            \
                           label.highlight=on
