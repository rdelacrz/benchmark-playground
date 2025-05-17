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
  dotnet publish -p:PublishSingleFile=true --self-contained true -c Release -o ./bin/Release/out
else
  echo "Configuring for Debug build..."
  dotnet publish -p:PublishSingleFile=true --self-contained true -c Debug -o ./bin/Debug/out
fi