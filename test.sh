#!/bin/bash

# Base directory containing the language subfolders
LANGUAGES_DIR="./languages"

# Check if the languages directory exists
if [ ! -d "$LANGUAGES_DIR" ]; then
  echo "Error: Directory $LANGUAGES_DIR does not exist."
  exit 1
fi

# Iterate through each subdirectory in the languages directory
for dir in "$LANGUAGES_DIR"/*/; do
  # Check if run.sh exists in the subdirectory
  if [ -f "${dir}test.sh" ]; then
    # Change to the directory and execute the run.sh script with the provided arguments
    (cd "$dir" && ./test.sh)
  else
    echo "No test.sh found in $dir"
  fi
done