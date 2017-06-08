# https://github.com/kdelfour/cloud9-docker/blob/master/Dockerfile

FROM debian:jessie-slim

ENV DEBIAN_FRONTEND noninteractive

# Upgrade
RUN apt-get update && apt-get -y dist-upgrade

# Install some packages for Cloud9
RUN apt-get install -y --no-install-recommends nano git wget curl openssl ca-certificates build-essential python sshfs

# Install cloud9
RUN git clone https://github.com/c9/core.git /cloud9 && \
    cd /cloud9                                       && \
    scripts/install-sdk.sh
WORKDIR /cloud9

# Clean packages
RUN apt-get -y autoremove --purge python build-essential && \
    apt-get -y autoclean                                 && \
    apt-get -y clean                                     && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Copy customization files
COPY files/.profile /etc/bash.bashrc
COPY files/TZParis  /etc/localtime

RUN chmod 644 /etc/profile               && \
    chmod 644 /etc/localtime             && \
    echo "Europe/Paris" > /etc/timezone

# Install git-aware-prompt
RUN cd && git clone git://github.com/jimeh/git-aware-prompt.git
RUN echo 'GITAWAREPROMPT=~/git-aware-prompt'  >> /etc/bash.bashrc
RUN echo 'source "${GITAWAREPROMPT}/main.sh"' >> /etc/bash.bashrc
RUN echo "PS1='\${debian_chroot:+(\$debian_chroot)}\[\033[01;34m\]\u@\h\[\033[01;32m\] \\t \[\033[01;33m\]\w\[\033[00m\] \[\$txtcyn\]\$git_branch\[\$txtred\]\$git_dirty\[\$txtrst\] \\$ '" >> /etc/bash.bashrc

RUN mkdir /workspace
VOLUME /workspace

EXPOSE 80

CMD ["/root/.c9/node/bin/node", "/cloud9/server.js", "-p", "80", "-l", "0.0.0.0", "-w", "/workspace", "-a", ":"]
