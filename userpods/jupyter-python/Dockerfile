FROM quay.io/accord/theia-jupyter-base:latest

# Basic config changes for jupyter-python
RUN ln -s /usr/bin/pip3 /usr/bin/pip && ln -s /usr/bin/python3 /usr/bin/python
ENV PIP_TARGET=/home/user/.local/

# Jupyter boilerplate

EXPOSE 8888
WORKDIR /home
USER 490
ENTRYPOINT [ "entrypoint-jupyter.sh" ]
# /Jupyter boilerplate
