#!/bin/sh

PLUGIN_DIR="$HOME/.config/sketchybar/plugins"

sketchybar --add event window_change

# The ICONS_SPACE array is sourced from constants.sh, ensure it's available
# If constants.sh is not sourced here, this script may not find ICONS_SPACE
# source "$HOME/.config/constants.sh" 

# Dynamically get the number of spaces from yabai
SPACES=$(yabai -m query --spaces)
SPACE_COUNT=$(echo "$SPACES" | jq 'length')

# Fallback to a default icon if ICONS_SPACE is not long enough
DEFAULT_ICON="􀏎" 

for i in $(seq 0 $(($SPACE_COUNT - 1)))
do
  sid=$(($i+1))
  icon="${ICONS_SPACE[i]:-$DEFAULT_ICON}" # Use default icon if not set for the space
  
  PAD_LEFT=2
  PAD_RIGHT=2
  if [[ $i == 0 ]]; then
    PAD_LEFT=8
  elif [[ $i == $(($SPACE_COUNT-1)) ]]; then
    PAD_RIGHT=8
  fi

  sketchybar --add space space.$sid left                                       \
             --set       space.$sid script="$PLUGIN_DIR/app_space.sh"          \
                                    associated_space=$sid                      \
                                    padding_left=$PAD_LEFT                     \
                                    padding_right=$PAD_RIGHT                   \
                                    background.color=$COLOR_WHITE_BRIGHT_TRANSP \
                                    background.corner_radius=5         \
                                    background.height=16               \
                                    icon="$icon"                               \
                                    icon.color=$COLOR_WHITE_BRIGHT_TRANSP      \
                                    label="_"                                  \
                                    label.color=$COLOR_WHITE_BRIGHT_TRANSP     \
             --subscribe space.$sid front_app_switched window_change
done
