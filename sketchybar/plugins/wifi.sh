#!/bin/sh

source "$HOME/.config/constants.sh"

# --- FINAL, MORE ROBUST METHOD ---

# First, get the raw status from networksetup.
# We find the Wi-Fi interface (e.g., en0) and get its network status.
WIFI_INFO=$(networksetup -getairportnetwork "$(networksetup -listallhardwareports | awk '/Hardware Port: Wi-Fi/{getline; print $2}')")

# Check for VPN connection first, as it takes precedence.
IS_VPN=$(scutil --nwi | grep -m1 'utun' | awk '{ print $1 }')

if [[ $IS_VPN != "" ]]; then
  COLOR=$COLOR_CYAN
  ICON=$ICON_VPN
  LABEL="VPN"
# Now, check if the Wi-Fi is actually connected by looking for the known prefix.
elif [[ "$WIFI_INFO" == "Current Wi-Fi Network: "* ]]; then
  COLOR=$COLOR_BLUE
  ICON=$ICON_WIFI
  # If connected, strip the prefix to get only the SSID.
  LABEL=$(echo "$WIFI_INFO" | sed 's/Current Wi-Fi Network: //')
else
  # If the prefix isn't there, we are not connected to Wi-Fi.
  COLOR=$COLOR_WHITE
  ICON=$ICON_WIFI_OFF
  LABEL="Not Connected"
fi

sketchybar --set $NAME background.color=$COLOR_WHITE_BRIGHT_TRANSP \
  icon=$ICON \
  label="$LABEL"
