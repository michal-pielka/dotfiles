#!/bin/zsh

# Define your preferred terminal selection logic here
# Example: Read preferred terminal from an environment variable, fallback to default
TERM_APP="${TERMINAL_APP:-Alacritty}"

case "$TERM_APP" in
  "Alacritty") open -na "Alacritty" ;;
  "iTerm")     open -na "iTerm" ;;
  "Terminal")  open -na "Terminal" ;;
  *)           open -na "Terminal" ;;
esac
