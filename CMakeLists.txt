cmake_minimum_required(VERSION "3.22")

project(sample_project LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

include(${CMAKE_BINARY_DIR}/build/Release/generators/conan_toolchain.cmake)

add_subdirectory(app)

if (BUILD_TESTS)
    add_subdirectory(tests)
endif()