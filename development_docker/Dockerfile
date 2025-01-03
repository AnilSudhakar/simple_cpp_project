FROM ubuntu:latest

ARG LOCAL_USER_ID
ARG LOCAL_GROUP_ID

USER root

RUN apt-get update && apt-get install -y \
    gcc-9 \
    g++-9 \
    cmake \
    ninja-build \
    curl \
    nano \
    git \
    python3 \
    python3-pip \
    python3-venv \
    python3-setuptools \
    build-essential \
    libyaml-dev \
    cython3

# RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 100 \
#     && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 100

ADD helper/fixuid /home/docker/fixuid

RUN cat /home/docker/fixuid/fixuid*.tar.gz | tar -C /usr/local/bin -xzf - && \
    chown root:root /usr/local/bin/fixuid && \
    chmod 4755 /usr/local/bin/fixuid && \
    mkdir -p /etc/fixuid && \
    cat /home/docker/fixuid/fixuid-config.yml > /etc/fixuid/config.yml && \
    rm -rf /home/docker/fixuid
    
CMD ["/bin/bash"]

RUN ln -s /usr/bin/python3 /usr/bin/python

ADD requirements.txt /

RUN python3 -m venv /opt/venv && \
    . /opt/venv/bin/activate && \
    pip install --upgrade pip setuptools wheel && \
    pip install -r requirements.txt && \
    deactivate && \
    rm requirements.txt

RUN LOCAL_USER_ID=$(id -u) && LOCAL_GROUP_ID=$(id -g)

USER ${LOCAL_USER_ID}:${LOCAL_GROUP_ID}

RUN mkdir -p /home/docker && chown -R ${LOCAL_USER_ID}:${LOCAL_GROUP_ID} /home/docker

WORKDIR /home/docker

ENV PATH=/opt/venv/bin:$PATH

ENTRYPOINT ["fixuid", "-q"]
