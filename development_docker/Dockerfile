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
    existing_group=$(getent group 118 | cut -d: -f1 || true); \
    if [ -z "$existing_group" ]; then \
        groupadd -g 118 docker; \
    else \
        echo "Group with GID 118 already exists: $existing_group"; \
    fi; \
    existing_user=$(getent passwd 1001 | cut -d: -f1 || true); \
    if [ -z "$existing_user" ]; then \
        useradd -m -u 1001 -g 118 runner; \
    else \
        echo "User with UID 1001 already exists: $existing_user"; \
    fi; \
    mkdir -p /home/runner && chown -R 1001:118 /home/runner

# Switch to the new user
USER 1001

WORKDIR /home/docker

RUN pipx install conan && \
    echo 'export PATH=$HOME/.local/bin:$PATH' >> ~/.bashrc && \
    . ~/.bashrc
