#!/bin/bash

# Initialize flags
release=true

# Parse command line arguments
while getopts "d" opt; do
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
  echo "Configuring for Release build..."
  CC=clang cmake -G Ninja -S . -B target/release -D CMAKE_BUILD_TYPE=Release
else
  echo "Configuring for Debug build..." -D CMAKE_BUILD_TYPE=Debug
  CC=clang cmake -G Ninja -S . -B target/debug -D CMAKE_BUILD_TYPE=Debug
fi