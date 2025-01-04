cmake_minimum_required(VERSION "3.22")

project(SimpleCppProject LANGUAGES CXX)

option(BUILD_TESTS "Builds tests available in the project" OFF)
option(BUILD_PACKAGE "Builds the package" OFF)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_EXTENSIONS ON)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if (BUILD_PACKAGE)
    include(${CMAKE_BINARY_DIR}/generators/conan_toolchain.cmake)
else()
    message(STATUS "CMAKE_BINARY_DIR: ${CMAKE_BINARY_DIR}")
    include(${CMAKE_BINARY_DIR}/build/Release/generators/conan_toolchain.cmake)
endif()

add_subdirectory(app)

if (BUILD_TESTS)
    list(APPEND CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
    include(UnitTest)
    add_subdirectory(tests)
endif()

install(
    EXPORT
        ${PROJECT_NAME}-EXPORT_GROUP
    FILE
        ${PROJECT_NAME}Targets.cmake
    DESTINATION
        ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
)

include(CMakePackageConfigHelpers)
configure_package_config_file(
    ${CMAKE_CURRENT_SOURCE_DIR}/${PROJECT_NAME}Config.cmake.in
    "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
    INSTALL_DESTINATION
        ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
)
install(
    FILES
        "${CMAKE_CURRENT_BINARY_DIR}/${PROJECT_NAME}Config.cmake"
    DESTINATION
        ${CMAKE_INSTALL_LIBDIR}/cmake/${PROJECT_NAME}
)
