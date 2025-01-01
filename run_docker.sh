#!/bin/bash

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
  -v "$ABSOLUTE_PATH/../simple_cpp_project:/home/docker"
  -v "/home/$USER/.conan:/home/ubuntu/.conan2"
  -e LOCAL_USER_ID=$USER_ID
  -e LOCAL_GROUP_ID=$GROUP_ID
  -it development_docker
)

docker run "${DOCKER_RUN_ARGS[@]}"
