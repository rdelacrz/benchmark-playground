#!/bin/bash

# Designed to only run with release version of build
# Example: ./run.sh -o QuickSort -i ../../inputs/random_string_list.json -c 1000
./target/release/cpp_benchmark_runner $@