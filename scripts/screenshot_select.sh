pkill mako
grim -g "$(slurp)" - | wl-copy
notify-send "Screenshot" "Selected area copied to clipboard"
