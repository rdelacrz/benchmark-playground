cmake_minimum_required(VERSION 3.28)
project(CBenchmarkRunner)            # Name of project

# Set the C standard
set(CMAKE_C_STANDARD 23)                # https://cmake.org/cmake/help/latest/prop_tgt/C_STANDARD.html

# Set optimization flags for compilation
add_compile_options(-O3)

# Include header file directories
include_directories(include)

# Find all source files in the src directory
file(GLOB_RECURSE SOURCES "src/*.c")    # Recursively find all .c files in src

# Creates the executable
add_executable(${PROJECT_NAME} ${SOURCES})   # Sets desired executable name

# Needed to reference CMAKE install directories used by cJSON
include(GNUInstallDirs)

# Link the cJSON library
set(CJSON_LIB cjson)
target_link_directories(${PROJECT_NAME} PRIVATE ${CMAKE_INSTALL_FULL_LIBDIR})
target_link_libraries(${PROJECT_NAME} ${CJSON_LIB})
target_include_directories(${PROJECT_NAME} PRIVATE ${CMAKE_INSTALL_FULL_INCLUDEDIR}/${CJSON_LIB})