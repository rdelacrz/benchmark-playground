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
  mkdir -p ./target/release
  crystal build --release --no-debug -o ./target/release/crystal_benchmark_runner src/main.cr
else
  echo "Configuring for Debug build..."
  mkdir -p ./target/debug
  crystal build -o ./target/debug/crystal_benchmark_runner src/main.cr
fi