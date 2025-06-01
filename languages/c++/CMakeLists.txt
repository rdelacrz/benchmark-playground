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
### Unit Testing Setup
###############################

set(TEST_EXECUTABLE ${PROJECT_NAME}_test)

file(GLOB_RECURSE OPERATION_SOURCES "src/operations/*.cpp")    # Recursively find all .cpp files in operations
file(GLOB_RECURSE TEST_SOURCES "test/*.cpp")    # Recursively find all .cpp files in test
add_executable(${TEST_EXECUTABLE} ${OPERATION_SOURCES} ${TEST_SOURCES})


###############################
### Library Dependencies
###############################

find_package(RapidJSON)

find_package(doctest)
target_compile_features(${TEST_EXECUTABLE} PRIVATE cxx_std_26)
target_link_libraries(${TEST_EXECUTABLE} PRIVATE doctest::doctest)