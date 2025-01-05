cmake_minimum_required(VERSION "3.22")

project(packageTest LANGUAGES CXX)

find_package(simple_cpp_project REQUIRED)

add_executable(testApp 
    src/main.cpp
    )

# This is necessary to find the header files and libraries installed by the package
target_include_directories(testApp
    PRIVATE
        ${simple_cpp_project_INCLUDE_DIRS}
    )

target_link_directories(testApp
    PRIVATE
        ${simple_cpp_project_INCLUDE_DIRS}/../lib
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
