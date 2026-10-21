#!/usr/bin/env bash

geometry=$(slurp) || exit 0

text=$(grim -g "$geometry" - | tesseract - stdout -l eng+pol 2>/dev/null)

if [ -n "$text" ]; then
	printf '%s' "$text" | wl-copy
	notify-send "Screen OCR" "Text copied to clipboard"
else
	notify-send "Screen OCR" "No text found"
fi
