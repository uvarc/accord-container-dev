ARG REGISTRY
FROM ${REGISTRY}/accord/centos7-base:latest

RUN pip3 install jupyterlab && \
  # smoke test
  jupyter lab --version
COPY disable-auth.json /usr/local/etc/jupyter/jupyter_notebook_config.d/disable-auth.json
