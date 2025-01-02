FROM ubuntu:latest

ARG LOCAL_USER_ID
ARG LOCAL_GROUP_ID

RUN apt-get update && apt-get install -y \
    gcc-9 \
    g++-9 \
    cmake \
    ninja-build \
    curl \
    python3-pip \
    python3-setuptools \
    python3-dev \
    python3-venv \
    pipx

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 100 \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 100

RUN set -eux; \
    existing_group=$(getent group ${LOCAL_GROUP_ID:-1000} | cut -d: -f1 || true); \
    if [ -z "$existing_group" ]; then \
        groupadd -g ${LOCAL_GROUP_ID:-1000} docker_group; \
    else \
        echo "Group with GID ${LOCAL_GROUP_ID:-1000} already exists: $existing_group"; \
    fi; \
    existing_user=$(getent passwd ${LOCAL_USER_ID:-1000} | cut -d: -f1 || true); \
    if [ -z "$existing_user" ]; then \
        useradd -m -u ${LOCAL_USER_ID:-1000} -g ${LOCAL_GROUP_ID:-1000} docker_user; \
    else \
        echo "User with UID ${LOCAL_USER_ID:-1000} already exists: $existing_user"; \
    fi; \
    mkdir -p /home/docker && chown -R ${LOCAL_USER_ID:-1000}:${LOCAL_GROUP_ID:-1000} /home/docker

USER ${LOCAL_USER_ID:-1000}

WORKDIR /home/docker

RUN pipx install conan && \
    echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc
