#!/bin/bash

# Designed to only run with release version of build
# Example: ./run.sh -i ../../inputs/random.json -o quick_sort -c 1000 -v
exec "./target/release/RustBenchmarkRunner" "$@"