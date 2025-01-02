cmake_minimum_required(VERSION "3.15.7")

project(sample_project LANGUAGES CXX)

option(BUILD_TESTS "Builds tests available in the project" OFF)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_EXTENSIONS ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(${CMAKE_BINARY_DIR}/build/Release/generators/conan_toolchain.cmake)

add_subdirectory(app)

if (BUILD_TESTS)
    list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
    include(UnitTest)
    add_subdirectory(tests)
endif()
