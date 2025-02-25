#!/bin/bash

RED='\033[0;31m'
CLEAR='\033[0m'

BUILD_DIR="_build-output"

CI_BUILD="false"

ARGUMENT_LIST=(
  "ci-build"
)

OPTS=$(getopt \
  --longoptions "$(printf "%s," "${ARGUMENT_LIST[@]}")" \
  --name "$(basename "$0")" \
  --options "" \
  -- "$@"
)
if [ $? -ne 0 ]; then
  echo "Failed to parse options...exiting."
  exit 1
fi

eval set -- "$OPTS"

while true; do
  case "$1" in
  --ci-build)
    CI_BUILD="true"
    shift
    ;;
  --)
    shift
    break
    ;;
  esac
done

if [ "$CI_BUILD" == "true" ]; then
  echo "CI build detected. Running in CI mode..."
  conan profile detect
fi
conan install . --output-folder=$BUILD_DIR --build=missing
if [ $? -ne 0 ]; then
    echo -e "${RED}Conan failed to install dependencies. Check logs for additional information${CLEAR}"
    exit 1
fi

cmake -GNinja -B $BUILD_DIR -DCMAKE_TOOLCHAIN_FILE=$BUILD_DIR/build/Release/generators/conan_toolchain.cmake -DCMAKE_BUILD_TYPE=Release \
      -DBUILD_PACKAGE=OFF

if [ $? -ne 0 ]; then
    echo -e "${RED}CMake failed to generate build system. Check logs for additional information${CLEAR}"
    exit 1
fi

cmake --build $BUILD_DIR
if [ $? -ne 0 ]; then
    echo -e "${RED}Build failed. Check logs for additional information${CLEAR}"
    exit 1
fi

cmake --install $BUILD_DIR --prefix $BUILD_DIR/install
if [ $? -ne 0 ]; then
    echo -e "${RED}Installation failed. Check logs for additional information${CLEAR}"
    exit 1
fi
