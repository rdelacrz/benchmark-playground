#!/bin/bash

# Installs third-party libraries (typically only needs to be done once in a while)
cmake -S extern/cJSON -B extern/cJSON/build -D CMAKE_BUILD_TYPE=Release
make install -C extern/cJSON/build