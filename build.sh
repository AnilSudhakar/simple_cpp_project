#!/bin/bash

RED='\033[0;31m'
CLEAR='\033[0m'

BUILD_DIR="_build-output"

conan install . --output-folder=$BUILD_DIR --build=missing
if [ $? -ne 0 ]; then
    echo -e "${RED}Conan failed to install dependencies. Check logs for additional information${CLEAR}"
    exit 1
fi

cmake -GNinja -B $BUILD_DIR -DCMAKE_TOOLCHAIN_FILE=$BUILD_DIR/build/Release/generators/conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release

if [ $? -ne 0 ]; then
    echo -e "${RED}CMake failed to generate build system. Check logs for additional information${CLEAR}"
    exit 1
fi

cmake --build $BUILD_DIR
if [ $? -ne 0 ]; then
    echo -e "${RED}Build failed. Check logs for additional information${CLEAR}"
    exit 1
fi
