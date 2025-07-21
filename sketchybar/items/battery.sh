#!/bin/sh

PLUGIN_DIR="$HOME/.config/sketchybar/plugins"

sketchybar --add item  battery right                                 \
           --set       battery script="$PLUGIN_DIR/battery.sh"       \
                       padding_left=8                                \
           --subscribe battery system_woke power_source_change
