#!/bin/bash

# Installs third-party libraries (typically only needs to be done once in a while)
cmake -S extern/cJSON -B extern/cJSON/build -D CMAKE_BUILD_TYPE=Release -D CMAKE_POLICY_VERSION_MINIMUM=3.5
make install -C extern/cJSON/build

cmake -S extern/Unity -B extern/Unity/build
make install -C extern/Unity/build