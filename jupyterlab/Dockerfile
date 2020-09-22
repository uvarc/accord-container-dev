ARG REGISTRY
FROM ${REGISTRY}/accord/centos7-base:latest

RUN pip3 install jupyterlab && \
  # smoke test
  jupyter lab --version
COPY jupyter_notebook_config.py /usr/local/etc/jupyter/jupyter_notebook_config.py
