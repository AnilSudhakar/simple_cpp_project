cmake_minimum_required(VERSION "3.22")

project(packageTest LANGUAGES CXX)

find_package(simple_cpp_project REQUIRED)
list(APPEND CMAKE_FIND_ROOT_PATH ${CMAKE_MODULE_PATH})

message(STATUS "CMAKE_MODULE_PATH: ${CMAKE_MODULE_PATH}")
message(STATUS "CMAKE_FIND_ROOT_PATH: ${CMAKE_FIND_ROOT_PATH}")

find_package(SimpleCppProject REQUIRED)

add_executable(testApp 
    src/main.cpp
    )


target_compile_features(testApp 
    PRIVATE
        cxx_std_17
    )
set_target_properties(testApp 
    PROPERTIES
        CXX_EXTENSIONS OFF
        CMAKE_CXX_STANDARD_REQUIRED ON
    )
target_link_libraries(testApp 
    PRIVATE
        logger
    )
