#!/bin/sh

PLUGIN_DIR="$HOME/.config/sketchybar/plugins"

sketchybar --add item  volume right                                  \
           --set       volume script="$PLUGIN_DIR/volume.sh"         \
                              background.border_width=0              \
                              background.height=24                   \
           --subscribe volume volume_change
