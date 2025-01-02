FROM conanio/gcc11-ubuntu16.04:2.2.2

# Ensure the user is root
USER root

RUN apt-get update && apt-get install -y \
    ninja-build

RUN mkdir -p /home/docker

WORKDIR /home/docker
