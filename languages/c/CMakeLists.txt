cmake_minimum_required(VERSION 3.28)
project(c_benchmark_runner)            # Name of project

# Set the C standard
set(CMAKE_C_STANDARD 23)                # https://cmake.org/cmake/help/latest/prop_tgt/C_STANDARD.html

# Set optimization flags for compilation
add_compile_options(-O3)

# Include header file directories
include_directories(include)


###############################
### Main Executable Setup
###############################

file(GLOB_RECURSE SOURCES "src/*.c")    # Recursively find all .c files in src
add_executable(${PROJECT_NAME} ${SOURCES})


###############################
### Unit Testing Setup
###############################

set(TEST_EXECUTABLE ${PROJECT_NAME}_test)

file(GLOB_RECURSE OPERATION_SOURCES "src/operations/*.c")    # Recursively find all .c files in operations
file(GLOB_RECURSE TEST_SOURCES "test/*.c")    # Recursively find all .c files in test
add_executable(${TEST_EXECUTABLE} ${OPERATION_SOURCES} ${TEST_SOURCES})


###############################
### Library Dependencies
###############################

# Initial setup
set(CJSON_LIB cjson)
include(GNUInstallDirs)     # Needed to reference CMAKE install directories used by other libraries

# For main benchmarker logic
target_link_directories(${PROJECT_NAME} PRIVATE ${CMAKE_INSTALL_FULL_LIBDIR})
target_link_libraries(${PROJECT_NAME} ${CJSON_LIB})
target_include_directories(${PROJECT_NAME} PRIVATE ${CMAKE_INSTALL_FULL_INCLUDEDIR}/${CJSON_LIB})

# For unit testing
set(UNITY_LIB unity)
target_link_directories(${TEST_EXECUTABLE} PRIVATE ${CMAKE_INSTALL_FULL_LIBDIR})
target_link_libraries(${TEST_EXECUTABLE} ${CJSON_LIB})
target_include_directories(${TEST_EXECUTABLE} PRIVATE ${CMAKE_INSTALL_FULL_INCLUDEDIR}/${CJSON_LIB})
target_link_libraries(${TEST_EXECUTABLE} ${UNITY_LIB})
target_include_directories(${TEST_EXECUTABLE} PRIVATE ${CMAKE_INSTALL_FULL_INCLUDEDIR}/${UNITY_LIB})
