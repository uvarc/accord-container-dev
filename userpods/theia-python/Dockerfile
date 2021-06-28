FROM quay.io/accord/theia-jupyter-base:latest

# Basic changes for theia-python
RUN ln -s /usr/bin/pip3 /usr/bin/pip && ln -s /usr/bin/python3 /usr/bin/python

# Theia boilerplate
EXPOSE 3000
ENV SHELL=/bin/bash \
  THEIA_DEFAULT_PLUGINS=local-dir:/usr/local/theia/plugins \
  USE_LOCAL_GIT=true \
  PIP_TARGET=/home/user/.local/
WORKDIR /usr/local/theia
USER 490
ENTRYPOINT [ "entrypoint-theia.sh" ]
# /Theia boilerplate
