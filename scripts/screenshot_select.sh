grim -g "$(slurp)" - | wl-copy --type image/png
notify-send "Screenshot" "Selected area copied to clipboard"
