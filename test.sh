#!/bin/bash

# Base directory containing the language subfolders
LANGUAGES_DIR="./languages"

# Check if the languages directory exists
if [ ! -d "$LANGUAGES_DIR" ]; then
  echo "Error: Directory $LANGUAGES_DIR does not exist."
  exit 1
fi

# For formatting purposes
width=$(tput cols)
char="#"

# Iterate through each subdirectory in the languages directory
for dir in "$LANGUAGES_DIR"/*/; do
  # Check if run.sh exists in the subdirectory
  if [ -f "${dir}test.sh" ]; then
    dir_without_language_prefix="${dir#./languages/}"
    language_name="${dir_without_language_prefix%/}"
    echo -e "\e[1;36m"
    printf "%-${width}s" "" | tr " " "$char"
    echo "## Running test cases for '$language_name'"
    printf "%-${width}s" "" | tr " " "$char"
    echo -e "\e[0m"
    # Change to the directory and execute the run.sh script with the provided arguments
    (cd "$dir" && ./test.sh)
  else
    echo "No test.sh found in $dir"
  fi
done