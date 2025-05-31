#!/bin/bash

# Installs third-party libraries (typically only needs to be done once in a while)
cmake -S extern/rapidjson -B extern/rapidjson/build -D CMAKE_BUILD_TYPE=Release -D CMAKE_POLICY_VERSION_MINIMUM=3.5
make install -C extern/rapidjson/build