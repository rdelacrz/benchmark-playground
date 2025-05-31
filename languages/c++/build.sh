#!/bin/bash

# Initialize flags
release=true

# Parse command line arguments
while getopts "rd" opt; do
  case $opt in
    d)
      release=false
      ;;
    *)
      echo "Usage: $0 [-d]"
      exit 1
      ;;
  esac
done

# Run the appropriate cmake command based on the flags
if [ $release == true ]; then
  echo "Building Release target..."
  mkdir -p ./target/release
  cmake --build target/release
else
  echo "Building Debug target..."
  mkdir -p ./target/debug
  cmake --build target/debug
fi