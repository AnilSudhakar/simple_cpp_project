#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
CLEAR='\033[0m'

if [ -d "_build-output" ]; then
    rm -rf _build-output
    echo -e "${GREEN}Removed existing _build-output directory${CLEAR}"
else
    echo -e "${RED}No _build-output directory found${CLEAR}"
fi
