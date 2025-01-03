FROM ubuntu:latest

ARG LOCAL_USER_ID
ARG LOCAL_GROUP_ID

USER root

COPY toolchain_catalog.apt-get.packages /

RUN apt-get update \
    && \
    echo "Installing via apt-get ..." \
    && \
    bash -c "apt-get install -y  $(cat /toolchain_catalog.apt-get.packages | tr '\n' ' ')" \
    && \
    rm /toolchain_catalog.apt-get.packages \
    && \
    apt-get clean \
    && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
    && echo "Finished"

RUN update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 100 \
    && update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 100

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
    pip install -r requirements.txt && \
    deactivate && \
    rm requirements.txt

RUN LOCAL_USER_ID=$(id -u) && LOCAL_GROUP_ID=$(id -g)

USER ${LOCAL_USER_ID}:${LOCAL_GROUP_ID}

RUN mkdir -p /home/docker && chown -R ${LOCAL_USER_ID}:${LOCAL_GROUP_ID} /home/docker

WORKDIR /home/docker

ENV PATH=/opt/venv/bin:$PATH

ENTRYPOINT ["fixuid", "-q"]
