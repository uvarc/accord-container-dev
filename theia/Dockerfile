ARG REGISTRY
FROM ${REGISTRY}/accord/node10:latest

# Install Python 3 from source
ARG VERSION=3.8.3

WORKDIR /home/theia
# See : https://github.com/theia-ide/theia-apps/issues/34
# Add user / group to be updated with /etc/passwd & /etc/group configmaps
RUN groupadd --gid 201 theia && \
    adduser --disabled-password --uid 201 --gid 201 --gecos '' theia && \
    groupadd --gid 1001 project && \
    adduser --disabled-password --uid 1000 --gid 1001 --gecos '' user && \
    chmod g+rw /home && \
    mkdir -p /home/project && \
    chgrp project /home/project && \
    chown -R theia:theia /home/theia;

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get clean \
    && apt-get auto-remove -y \
    && rm -rf /var/cache/apt/* \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

USER theia
ARG version=latest
ADD $version.package.json ./package.json
ARG GITHUB_TOKEN
RUN yarn --pure-lockfile && \
    NODE_OPTIONS="--max_old_space_size=4096" yarn theia build && \
    yarn theia download:plugins && \
    yarn --production && \
    yarn autoclean --init && \
    echo *.ts >> .yarnclean && \
    echo *.ts.map >> .yarnclean && \
    echo *.spec.* >> .yarnclean && \
    yarn autoclean --force && \
    yarn cache clean
EXPOSE 3000
ENV SHELL=/bin/bash \
    THEIA_DEFAULT_PLUGINS=local-dir:/home/theia/plugins
USER theia
WORKDIR /home/theia
ENTRYPOINT [ "yarn", "theia", "start", "/home", "--hostname=0.0.0.0" ]
