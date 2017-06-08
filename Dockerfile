# https://github.com/kdelfour/cloud9-docker/blob/master/Dockerfile

FROM debian:jessie-slim

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get -y dist-upgrade

#RUN apt-get install -y --no-install-recommends nano git wget curl openssl ca-certificates build-essential python sshfs nodejs
RUN apt-get install -y --no-install-recommends nano git wget curl openssl ca-certificates build-essential python sshfs

RUN git clone https://github.com/c9/core.git /cloud9
WORKDIR /cloud9
RUN scripts/install-sdk.sh

COPY files/.profile /etc/bash.bashrc
RUN chmod 644 /etc/profile
COPY files/TZParis /etc/localtime
RUN chmod 644 /etc/localtime
RUN echo "Europe/Paris" > /etc/timezone

RUN mkdir /workspace
VOLUME /workspace

RUN apt-get -y autoremove --purge python build-essential && apt-get -y autoclean && apt-get -y clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

EXPOSE 80

#ENV ENV /etc/profile
ENV EDITOR nano


CMD ["/root/.c9/node/bin/node", "/cloud9/server.js", "-p", "80", "-l", "0.0.0.0", "-w", "/workspace", "-a", ":"]
