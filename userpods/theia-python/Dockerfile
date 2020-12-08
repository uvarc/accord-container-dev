FROM quay.io/accord/theia-jupyter-base:latest

# No changes for theia-python

# Theia boilerplate
EXPOSE 3000
ENV SHELL=/bin/bash \
  THEIA_DEFAULT_PLUGINS=local-dir:/usr/local/theia/plugins \
  USE_LOCAL_GIT=true
WORKDIR /usr/local/theia
USER 490
ENTRYPOINT [ "entrypoint-theia.sh" ]
# /Theia boilerplate
