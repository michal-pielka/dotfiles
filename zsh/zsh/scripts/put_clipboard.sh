#!/bin/bash

API_URL="https://api.jsonbin.io/v3"
url="$API_URL/b/$BIN_ID"

clipboard=$(wl-paste)

curl -s -X PUT "$url" \
	-H "Content-Type: application/json" \
	-H "X-Access-Key: $JSONBIN_CLIPBOARD_ACCESS_KEY" \
	-d "{\"clipboard\": \"$clipboard\"}" > /dev/null 2>&1
