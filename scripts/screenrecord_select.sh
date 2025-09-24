SIG=8
STATE="$XDG_RUNTIME_DIR/wf_recording.state"
DIR="$HOME/videos/screen_recordings"
mkdir -p "$DIR"

if [[ -f $STATE ]]; then
	# Stop recording
	source "$STATE"
	pkill -INT -x wf-recorder 2>/dev/null
	rm -f "$STATE"
else
	# Start recording
	FILE="$DIR/$(date +%d_%m_%H_%M_%S).mp4"
	wf-recorder -g "$(slurp)" -f "$FILE" &
	echo "PID=$!" >"$STATE"; echo "FILE=$FILE" >>"$STATE"
fi

pkill -RTMIN+${SIG} waybar 2>/dev/null || true
