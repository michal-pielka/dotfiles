#!/bin/bash

input="$1"

IFS=$'\n' read -d '' -ra lines <<< "$(echo -e "$input")"

echo "{"
for line in "${lines[@]}"; do
    header_key="${line%%: *}"
    header_value="${line#*: }"
    echo '    "$left": "$right,"'
echo "}"


done
