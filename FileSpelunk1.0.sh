#!/bin/bash
# FileSpelunk1.0.sh
# Recursively search files for multiple strings across any part of the file.

# === LOAD CONFIG FROM YAML ===
CONFIG_FILE="./src/config.yml"
# Optional CLI override: ./FileSpelunk1.0.sh [search_path] [output_file]
if [ -n "$1" ]; then SEARCH_PATH="$1"; fi
if [ -n "$2" ]; then OUTPUT_FILE="$2"; fi
SEARCH_PATH=$(grep 'search_path:' "$CONFIG_FILE" | cut -d':' -f2- | xargs)
OUTPUT_FILE=$(grep 'output_file:' "$CONFIG_FILE" | cut -d':' -f2- | xargs)
IFS=$'\n' read -d '' -r -a STRINGS < <(grep '^  -' "$CONFIG_FILE" | sed 's/^- //' && printf '\0')

# === FUNCTION ===
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: config.yml not found at $CONFIG_FILE"
    exit 1
fi

search_files() {
    echo "Filename,Last Modified,Extension,Matched Lines" > "$OUTPUT_FILE"
    local file_count=0
    local match_count=0

    find "$SEARCH_PATH" -type f \( -iname "*.txt" -o -iname "*.log" -o -iname "*.csv" -o -iname "*.rtf" \
                            -o -iname "*.xml" -o -iname "*.json" -o -iname "*.html" -o -iname "*.htm" -o -iname "*.eml" \) | while read -r file; do

        ((file_count++))
        file_content=$(strings "$file" 2>/dev/null)
        include=true

        for term in "${STRINGS[@]}"; do
            echo "$file_content" | grep -iq "$term" || include=false
        done

        if [ "$include" = true ]; then
            ((match_count++))
            mod_date=$(stat -c %y "$file" | cut -d'.' -f1)
            ext=".${file##*.}"
            matched_lines=$(echo "$file_content" | grep -iE "$(IFS='|'; echo "${STRINGS[*]}")" | tr '\n' ' ')
            echo "\"$file\",\"$mod_date\",\"$ext\",\"$matched_lines\"" >> "$OUTPUT_FILE"
        fi

        echo -ne "Scanning: $file_count files, $match_count matches...\r"
    done

    echo -e "\n Done. Results saved to $OUTPUT_FILE"
}

search_files
