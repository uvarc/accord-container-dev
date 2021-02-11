FROM quay.io/accord/theia-jupyter-base:latest

# No changes for jupyter-python
COPY requirements.txt requirements.txt
RUN pip3 install --user -r requirements.txt

# Jupyter boilerplate
EXPOSE 8888
WORKDIR /home
USER 490
ENTRYPOINT [ "entrypoint-jupyter.sh" ]
# /Jupyter boilerplate
