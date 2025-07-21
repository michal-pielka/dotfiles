#!/bin/sh

PLUGIN_DIR="$HOME/.config/sketchybar/plugins"

sketchybar --add item  ip_address right                              \
           --set       ip_address script="$PLUGIN_DIR/wifi.sh" \
                                  background.border_width=0          \
                                  background.corner_radius=5         \
                                  background.height=16               \
                                  padding_right=8                    \
                                  icon.highlight=on                  \
                                  label.highlight=on                 \
           --subscribe ip_address wifi_change
