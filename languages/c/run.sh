#!/bin/bash

# Designed to only run with release version of build
# Example: ./run.sh -o QuickSort -i ../../inputs/random.json -c 1000
./target/release/c_benchmark_runner $@