#!/bin/sh

# This file is responsible for the layout of the bar.
# It loads items and then groups them into brackets.

# Separator function
add_separator() {
  local name="$1"
  local position="$2"

  sketchybar --add item "$name" "$position" \
             --set "$name" padding_left=4         \
                           padding_right=4        \
                           background.drawing=off \
                           icon.drawing=off       \
                           label.drawing=off
}


# -----------------------------------------------------------------------------
# Left Side
# -----------------------------------------------------------------------------

# App Spaces
source "$ITEM_DIR/app_space.sh"
sketchybar --add bracket spaces '/space\..*/'                      \
           --set         spaces background.color=$COLOR_BACKGROUND

# Separator
add_separator sep_left_1 left

# -----------------------------------------------------------------------------
# Right Side
# -----------------------------------------------------------------------------

# Time, Date
source "$ITEM_DIR/time.sh"
source "$ITEM_DIR/date.sh"
sketchybar --add bracket clock time date                          \
           --set         clock background.color=$COLOR_BACKGROUND \
                               background.border_color=$COLOR_WHITE_BRIGHT_OPAQUE
# Separator
add_separator sep_right_1 right

# WiFi, Volume, Battery
source "$ITEM_DIR/wifi.sh"
source "$ITEM_DIR/cpu.sh"
source "$ITEM_DIR/volume.sh"
source "$ITEM_DIR/battery.sh"
sketchybar --add bracket status ip_address volume battery cpu           \
           --set         status background.color=$COLOR_BACKGROUND  \
                                background.border_color=$COLOR_WHITE_BRIGHT_OPAQUE
