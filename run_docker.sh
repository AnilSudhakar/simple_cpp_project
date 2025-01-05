#!/bin/bash

GREEN='\033[0;32m'
CLEAR='\033[0m'

DOCKER_IMAGE_NAME="anilkaiy.jfrog.io/docker-trial/development_docker"
TAG_NAME="1"

if [ "$(docker images -q $DOCKER_IMAGE_NAME:$TAG_NAME 2> /dev/null)" == "" ]; then
  echo -e "${GREEN}Docker image not found. Pulling from JFrog...${CLEAR}"
  docker pull $DOCKER_IMAGE_NAME:$TAG_NAME
else
  echo -e "${GREEN}Docker image found: $DOCKER_IMAGE_NAME:$TAG_NAME. Skipping pull...${CLEAR}"
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
  --user "$USER_ID:$GROUP_ID" --rm -it
  -v "$ABSOLUTE_PATH:/home/docker"
  -v "/home/$USER/.conan:/home/ubuntu/.conan2"
)

docker run "${DOCKER_RUN_ARGS[@]}" $DOCKER_IMAGE_NAME:$TAG_NAME
