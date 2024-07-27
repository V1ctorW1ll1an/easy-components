#!/bin/bash

ROOT_PATH="./src"
INPUT_PATH="$ROOT_PATH/input.css"
PATHS_TO_STAY_MONITORED=(
    "$ROOT_PATH/components"
    # "$ROOT_PATH/pages"
)
EXTENSIONS=("html" "js")
EXTENSIONS_LIST=$(printf ",%s" "${EXTENSIONS[@]}")
EXTENSIONS_LIST=${EXTENSIONS_LIST:1}  # Remove the leading comma
ACTION=$1
FILE_NAME=$2

show_help() {
  echo "Usage: $0 {minify|watch|minify:all} [component or page]"
  echo
  echo "Options:"
  echo "  minify         Generates CSS for a specific component or page."
  echo "  watch         Monitors changes in the files of a component or page and generates CSS automatically."
  echo "  minify:all     Generates CSS for all components and pages in their respective directories."
  echo
  echo "Examples:"
  echo " pnpm run tailwind:minify header         Generates CSS for the 'header' component."
  echo " pnpm run tailwind:minify home           Generates CSS for the 'home' page."
  echo " pnpm run tailwind:watch swiper         Monitors changes in the 'swiper' component and generates CSS automatically."
  echo " pnpm run tailwind:minify:all           Generates CSS for all components and pages."
}

find_file() {
    local filename="$1"
    local found_file=""

    for path in "${PATHS_TO_STAY_MONITORED[@]}"; do
        for ext in "${EXTENSIONS[@]}"; do
            # /dev/bull silence the default error msg
            found=$(find "$path" -type f -name "$filename.$ext" 2>/dev/null)
            if [[ -n "$found" ]]; then
                found_file="$found"
                break 2
            fi
        done
    done

    if [[ -z "$found_file" ]]; then
        echo "Error, file:$FILE_NAME not found!" >&2
        return 1
    else
        local dir_path="${found_file%/*}"
        echo "$dir_path"
    fi
}

do_action() {
  FILE_PATH=$(find_file "$FILE_NAME" 2>/dev/null)
  if [ $? -ne 0 ]; then
    # redirect standard error output to the standard error descriptor
    echo "Error, file:$FILE_NAME not found!" >&2
    exit 1
  fi

  OUTPUT_FILE="$FILE_PATH/$FILE_NAME.css"

  echo "$ACTION all {${EXTENSIONS_LIST}} files in: $FILE_PATH/"
  npx tailwindcss -i "$INPUT_PATH" -o "$OUTPUT_FILE" --content "$FILE_PATH/*.{${EXTENSIONS_LIST}}" --$ACTION
}

minify_all() {
    for path in "${PATHS_TO_STAY_MONITORED[@]}"; do
        for dir in "$path"/*/; do
            dir_name=$(basename "$dir")
            OUTPUT_FILE="$dir/${dir_name}.css"
            echo "Minifying all files in: $dir"
            npx tailwindcss -i "$INPUT_PATH" -o "$OUTPUT_FILE" --content "$dir/*.{${EXTENSIONS_LIST}}" --minify
        done
    done
}



case $ACTION in
"minify") do_action;;
"watch") do_action;;
"minify:all") minify_all;;
*) show_help
esac
