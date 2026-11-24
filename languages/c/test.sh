#!/bin/bash

set -e

if [ ! -f target/release/CMakeCache.txt ]; then
  ./configure.sh
fi
cmake --build target/release --target c_benchmark_runner_test
./target/release/c_benchmark_runner_test