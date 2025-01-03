#!/bin/bash

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

DOCKER_IMAGE_NAME="anilkaiy.jfrog.io/docker-trial/development_docker"
TAG_NAME="1"

if [ "$(docker images -q $DOCKER_IMAGE_NAME:$TAG_NAME 2> /dev/null)" == "" ]; then
  echo "Docker image not found. Pulling from JFrog..."
  docker pull $DOCKER_IMAGE_NAME:$TAG_NAME
else
  echo "Docker image found: $DOCKER_IMAGE_NAME:$TAG_NAME. Skipping pull..."
fi

RELATIVE_PATH=$(dirname "$0")
ABSOLUTE_PATH=$(cd "$RELATIVE_PATH"; pwd)

USER_ID=$(id -u)
GROUP_ID=$(id -g)

HOST_CONAN_DIR="/home/$USER/.conan"
if [ ! -d "$HOST_CONAN_DIR" ]; then
  mkdir -p "$HOST_CONAN_DIR"
  chown -R "$USER_ID:$GROUP_ID" "$HOST_CONAN_DIR"
fi

DOCKER_RUN_ARGS=(
  --user "$USER_ID:$GROUP_ID" --rm
  -v "$ABSOLUTE_PATH:/home/docker"
  -v "/home/$USER/.conan:/home/ubuntu/.conan2"
)

if [ "$CI_BUILD" == "false" ]; then
  DOCKER_RUN_ARGS+=(-it)
  echo "Running in interactive mode..."
fi

docker run "${DOCKER_RUN_ARGS[@]}" $DOCKER_IMAGE_NAME:$TAG_NAME
