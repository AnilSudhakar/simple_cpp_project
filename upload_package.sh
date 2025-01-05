#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
CLEAR='\033[0m'

echo "${GREEN}Uploading Conan package...${CLEAR}"

conan remote add simple-conan https://anilkaiy.jfrog.io/artifactory/api/conan/simple-conan
conan upload simple_cpp_project/1.0.0@official/release --remote=simple-conan --confirm
