#!/bin/bash

# Example: ./run.sh -i ../../inputs/random.json -o quick_sort -c 1000 -v

# Check if at least one argument is provided
if [ "$#" -lt 1 ]; then
  echo "Usage: $0 [args...]"
  exit 1
fi

# Store the command-line arguments
ARGS="$@"

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
  if [ -f "${dir}run.sh" ]; then
    echo "Executing ${dir}run.sh with arguments: $ARGS"
    # Change to the directory and execute the run.sh script with the provided arguments
    (cd "$dir" && ./run.sh $ARGS)
  else
    echo "No run.sh found in $dir"
  fi
done