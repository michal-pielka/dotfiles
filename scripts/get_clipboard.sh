#!/bin/bash

API_URL="https://api.jsonbin.io/v3"
url="$API_URL/b/$BIN_ID"

clipboard=$(curl -s -X GET "$url" \
  -H "Content-Type: application/json" \
  -H "X-Access-Key: $JSONBIN_CLIPBOARD_ACCESS_KEY" \
  | jq -r ".record.clipboard")

echo $clipboard | wl-copy 
