#!/bin/bash

# Designed to only run with release version of build
# Example: ./run.sh -o quick_sort -i ../../inputs/random.json -c 1000 -v
./target/release/CBenchmarkRunner $@