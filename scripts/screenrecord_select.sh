OUTPUT="$HOME/videos/screen_recordings/$(date +%s).mp4"

# Check if wf-recorder is running
if pgrep -x wf-recorder > /dev/null; then
    # Stop recording
    pkill -INT wf-recorder
    notify-send "Recording" "Saved: $OUTPUT"
else
    # Start recording
    wf-recorder -g "$(slurp)" -f "$OUTPUT" &
    notify-send "Recording"
fi
