#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE}")" && pwd)"
SCRIPT_NAME="$(basename "${BASH_SOURCE}")"

# Exclude the script, README.md, and your 2 custom files
EXCLUDE_FILES=("$SCRIPT_NAME" "README.md" "check_md5.sh" "license.md" )

# Print the Markdown table header to the terminal
printf "| File Name | MD5 Checksum |\n"
printf "| :--- | :--- |\n"

for file in "$SCRIPT_DIR"/*; do
    if [ -f "$file" ]; then
        filename="$(basename "$file")"
        
        skip=false
        for excluded in "${EXCLUDE_FILES[@]}"; do
            if [ "$filename" == "$excluded" ]; then
                skip=true
                break
            fi
        done

        if [ "$skip" = false ]; then
            hash=$(md5sum "$file" | awk '{print $1}')
            printf "| %s | \`%s\` |\n" "$filename" "$hash"
        fi
    fi
done
