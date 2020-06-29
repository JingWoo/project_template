# CMake version specification
cmake_minimum_required(VERSION 3.0 FATAL_ERROR)

# Register general cmake modules
include(cmake/Options.cmake)

# Set policies
cmake_policy(SET CMP0054 NEW) # ENABLE CMP0054: Only interpret if() arguments as variables or keywords when unquoted.

message(STATUS "Configuring on/for ${CMAKE_SYSTEM_NAME}")

# Project description
project(project_template LANGUAGES C CXX)

set(PROJECT_TEMPLATE_VERSION_MAJOR 0)
set(PROJECT_TEMPLATE_VERSION_MINOR 1)
set(PROJECT_TEMPLATE_VERSION_PATCH 0)
set(PROJECT_TEMPLATE_VERSION "${PROJECT_TEMPLATE_VERSION_MAJOR}.${PROJECT_TEMPLATE_VERSION_MINOR}.${PROJECT_TEMPLATE_VERSION_PATCH}")
# predefined variable
set(PROJECT_NAME "\"Project Template\"")
set(PROJECT_DESCRIPTION "\"A cmake project template\"")

# C/C++ version selection
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Include custom cmake modules
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
include(cmake/Version.cmake)

# Generate config file
configure_file(
    "${CMAKE_CURRENT_SOURCE_DIR}/config.h.in"
    "${CMAKE_BINARY_DIR}/conf/config.h"
)


# 
# Project description and (meta) information
# 
execute_process(
        COMMAND sh -c "date --rfc-3339 ns | sed -e 's/ /T/'"
        OUTPUT_VARIABLE BUILD_DATE
        OUTPUT_STRIP_TRAILING_WHITESPACE
)
message(STATUS "Build time: " ${BUILD_DATE})


#
# Configure CMake environment
#
if (NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
    message(STATUS "Setting build type to 'Release' as no build type was specified")
    set(CMAKE_BUILD_TYPE "Release" CACHE STRING "Choose the build type (Debug/Release)" FORCE)
endif (NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)

# Set runtime path
set(CMAKE_SKIP_BUILD_RPATH            FALSE) # Add absolute path to all dependencies for BUILD
set(CMAKE_BUILD_WITH_INSTALL_RPATH    FALSE) # Use CMAKE_INSTALL_RPATH for INSTALL
set(CMAKE_INSTALL_RPATH_USE_LINK_PATH FALSE) # Do NOT add path to dependencies for INSTALL

# 
# Project modules
# 
# add_subdirectory(src)
add_executable(project_template src/main.cpp)

if (BUILD_TESTS)
    include(CTest)
    enable_testing()
    add_subdirectory(test)
endif (BUILD_TESTS)

if (GEN_DOCS)
    add_subdirectory(doc)
endif (GEN_DOCS)

# 
# Deployment (global project files)
# 
