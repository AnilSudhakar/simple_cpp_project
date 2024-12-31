#!/bin/bash

RED='\033[0;31m'
CLEAR='\033[0m'

cmake -GNinja -B _build-output

chown -R $USER:$USER _build-output
chmod -R u+w _build-output

if [ $? -ne 0 ]; then
    echo -e "${RED}CMake failed to generate build system. Check logs for additional information${CLEAR}"
    exit 1
fi

cmake --build _build-output
if [ $? -ne 0 ]; then
    echo -e "${RED}Build failed. Check logs for additional information${CLEAR}"
    exit 1
fi
