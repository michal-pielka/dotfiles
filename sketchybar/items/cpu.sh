#!/bin/sh

PLUGIN_DIR="$HOME/.config/sketchybar/plugins"

sketchybar --add item cpu right                         \
           --set      cpu script="$PLUGIN_DIR/cpu.sh"   \
                          update_freq=5                 \
                          icon=$ICON_CPU                \
