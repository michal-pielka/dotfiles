#!/bin/sh

# This script is triggered by SketchyBar.
# The $NAME variable is automatically set by SketchyBar.
# It refers to the name of the bar item that called this script.
# More info: https://felixkratz.github.io/SketchyBar/config/events#events-and-scripting

sketchybar --set "$NAME" label="$(date '+%H:%M')"
