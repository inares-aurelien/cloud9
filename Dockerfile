FROM debian:jessie-slim


ENV DEBIAN_FRONTEND noninteractive

# Installation
RUN echo "\n\n\n***** Upgrade system *****\n"                                                                           && \
    apt-get update && apt-get -y dist-upgrade                                                                           && \
    \
    echo "\n\n\n***** Install some packages for Cloud9 *****\n"                                                         && \
    apt-get install -y --no-install-recommends nano git wget curl openssl ca-certificates build-essential python sshfs  && \
    \
    echo "\n\n\n***** Install Cloud9 *****\n"                                                                           && \
    git clone https://github.com/c9/core.git /cloud9                                                                    && \
    cd /cloud9                                                                                                          && \
    scripts/install-sdk.sh                                                                                              && \
    \
    echo "\n\n\n***** Make the NodeJS installed with Cloud9 available (WARNING: it is an old version) *****\n"          && \
    ln -s /root/.c9/node/bin/node /usr/bin/node                                                                         && \
    \
    echo "\n\n\n***** Install git-aware-prompt *****\n"                                                                 && \
    git clone git://github.com/jimeh/git-aware-prompt.git /root/git-aware-prompt                                        && \
    chmod u=rwX,g=,o= -R /root                                                                                          && \
    \
    echo "\n\n\n***** Clean the packages *****\n"                                                                       && \
    apt-get -y autoremove --purge python build-essential                                                                && \
    apt-get -y autoclean                                                                                                && \
    apt-get -y clean                                                                                                    && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /cloud9

    
# Customization
COPY files/.profile         /etc/bash.bashrc
COPY files/.bash_history    /root/.bash_history
COPY files/user.settings    /root/.c9/user.settings
COPY files/state.settings   /workspace/.c9/state.settings
COPY files/project.settings /workspace/.c9/project.settings
RUN ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime  && \
    echo "Europe/Paris" > /etc/timezone                     && \
    chmod 644 /etc/bash.bashrc                              && \
    chmod u=rwX,g=,o= -R /workspace

    
EXPOSE 80
VOLUME /workspace

# The shell form of CMD is used here to be able to kill NodeJS with CTRL+C (see https://github.com/nodejs/node-v0.x-archive/issues/9131)
CMD node /cloud9/server.js -p 80 -l 0.0.0.0 -w /workspace -a :
#CMD ["/root/.c9/node/bin/node", "/cloud9/server.js", "-p", "80", "-l", "0.0.0.0", "-w", "/workspace", "-a", ":"]
#CMD ["node", "/cloud9/server.js", "-p", "80", "-l", "0.0.0.0", "-w", "/workspace", "-a", ":"]
