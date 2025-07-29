#!/bin/bash

TOUCHPAD_NAME="apple-spi-trackpad"
DEVICE_KEY="device[$TOUCHPAD_NAME]:enabled"
CURRENT=$(hyprctl getoption "$DEVICE_KEY" | grep 'int: ' | awk '{print $2}')

if [ "$CURRENT" == "1" ]; then
    echo "siema 1"
    hyprctl keyword "$DEVICE_KEY" false
else
    echo "22222"
    hyprctl keyword "$DEVICE_KEY" true
fi
