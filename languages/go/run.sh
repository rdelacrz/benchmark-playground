#!/bin/bash

# Designed to only run with release version of build
# Example: ./run.sh -i ../../inputs/random_string_list.json -o QuickSort -c 1000
./target/release/go_benchmark_runner $@