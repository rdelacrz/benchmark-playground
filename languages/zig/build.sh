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

zig_version=0.14.1
if [ "$(zig version 2>/dev/null)" = "$zig_version" ]; then
  zig_cmd=(zig)
elif command -v mise >/dev/null 2>&1; then
  zig_cmd=(mise exec "zig@$zig_version" -- zig)
else
  echo "Zig $zig_version is required. Put it on PATH or install it with mise (see README.md)." >&2
  exit 1
fi
if [ $release == true ]; then
  echo "Configuring for Release build..."
  "${zig_cmd[@]}" build --release=fast --prefix ./zig-out/release
else
  echo "Configuring for Debug build..."
  "${zig_cmd[@]}" build --prefix ./zig-out/debug
fi