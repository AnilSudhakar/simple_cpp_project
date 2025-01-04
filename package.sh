#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
CLEAR='\033[0m'

ROOT_DIR=$(pwd)

echo -e "${GREEN}Building Conan package...${CLEAR}"

conan create -pr=default \
    --name=simple_cpp_project \
    --version=0.0.1 \
    --user=official \
    --channel=release \
    $ROOT_DIR

if [ $? -ne 0 ]; then
    echo -e "${RED}Conan failed to create package. Check logs for additional information${CLEAR}"
    exit 1
else
    echo -e "${GREEN}Conan package created successfully${CLEAR}"
fi
