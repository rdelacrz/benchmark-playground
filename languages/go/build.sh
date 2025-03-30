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
  go build -C src -ldflags="-s -w" -o ../target/release/GoBenchmarkRunner
else
  echo "Configuring for Debug build..."
  go build -C src -gcflags="all=-N -l" -o ../target/debug/GoBenchmarkRunner
fi