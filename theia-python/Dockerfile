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
    && apt-get install -y make build-essential libssl-dev \
    && apt-get install -y libbz2-dev libreadline-dev libsqlite3-dev wget curl llvm \
    && apt-get install -y libncurses5-dev  libncursesw5-dev xz-utils tk-dev \
    && wget https://www.python.org/ftp/python/$VERSION/Python-$VERSION.tgz \
    && tar xvf Python-$VERSION.tgz \
    && cd Python-$VERSION \
    && ./configure \
    && make -j8 \
    && make install \
    && cd .. \
    && rm -rf Python-$VERSION \
    && rm Python-$VERSION.tgz

RUN apt-get update \
    && apt-get install -y python-dev python-pip \
    && pip install --upgrade pip --user \
    && apt-get install -y python3-dev python3-pip \
    && pip3 install --upgrade pip --user \
    && pip install python-language-server flake8 autopep8 \
    && apt-get install -y yarn \
    && apt-get clean \
    && apt-get auto-remove -y \
    && rm -rf /var/cache/apt/* \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /tmp/*

USER theia
ARG version=latest
ADD $version.package.json ./package.json
ARG GITHUB_TOKEN
RUN yarn --cache-folder ./ycache && rm -rf ./ycache && \
     NODE_OPTIONS="--max_old_space_size=4096" yarn theia build ; \
    yarn theia download:plugins
EXPOSE 3000
ENV SHELL=/bin/bash \
    THEIA_DEFAULT_PLUGINS=local-dir:/home/theia/plugins
USER user
WORKDIR /home
ENTRYPOINT [ "yarn", "--cwd=/home/theia" "theia", "start", "/home", "--hostname=0.0.0.0" ]
