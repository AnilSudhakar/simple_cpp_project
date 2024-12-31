#!/bin/bash

RELATIVE_PATH=$(dirname "$0")
ABSOLUTE_PATH=$(cd "$RELATIVE_PATH"; pwd)

USER_ID=$(id -u)
GROUP_ID=$(id -g)

DOCKER_RUN_ARGS=(
  -v "$ABSOLUTE_PATH/../../simple_cpp_project:/home/docker"
  -e LOCAL_USER_ID=$USER_ID
  -e LOCAL_GROUP_ID=$GROUP_ID
  -it development_docker
)

docker run "${DOCKER_RUN_ARGS[@]}"
