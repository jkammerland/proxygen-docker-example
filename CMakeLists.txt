# The most minimal CMakeLists.txt file to build a proxygen server I could find

cmake_minimum_required(VERSION 3.15)
project(proxygen_server)

# Set C++17 as the default
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED True)

# Needed to find proxygen-config.cmake
list(APPEND CMAKE_PREFIX_PATH "/app/proxygen/_build")

# Needed to find sodium-config.cmake
list(APPEND CMAKE_MODULE_PATH "/app/proxygen/build/fbcode_builder/CMake")

# Otherwise you will not find sodium correctly. And if you install with
# packae-manager too, you get warnings
list(
  APPEND CMAKE_PREFIX_PATH
  "/app/proxygen/_build/libsodium-0Yx8uDQ0Elbwk9EKDCs5TNYm8JOW2lu3-qbRmzbRZZc")

# Find required libraries, for the eche server example
find_package(proxygen CONFIG REQUIRED)
find_package(gflags REQUIRED)
find_package(zstd CONFIG REQUIRED)
find_package(folly REQUIRED)
# find_package(sodium REQUIRED) # Will not work

add_executable(server EchoServer.cpp EchoHandler.cpp)

# Link the required libraries
target_link_libraries(server PUBLIC proxygen::proxygenhttpserver gflags zstd)

# This is needed to find libzstd, otherwise you get cannot find -lzstd
target_link_directories(
  server PUBLIC
  /app/proxygen/_build/zstd-uIccJ_axYH3rldyv5Ejnt7zosjL9uKB3JxuRih_IAvI/lib)
