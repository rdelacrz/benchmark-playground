cmake_minimum_required(VERSION 3.28)
project(cpp_benchmark_runner)            # Name of project

# Set the C++ standard
set(CMAKE_CXX_STANDARD 26)                # https://cmake.org/cmake/help/latest/prop_tgt/CXX_STANDARD.html

# Set optimization flags for compilation
add_compile_options(-O3)

# Include header file directories
include_directories(include)


###############################
### Main Executable Setup
###############################

file(GLOB_RECURSE SOURCES "src/*.cpp")    # Recursively find all .cpp files in src
add_executable(${PROJECT_NAME} ${SOURCES})


###############################
### Library Dependencies
###############################

find_package(RapidJSON)