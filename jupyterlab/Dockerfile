FROM jupyter/scipy-notebook:latest

# Full skel for homedir, configures notebook for no auth
COPY skel.tar.gz /usr/local/lib/skel.tar.gz
# Un-tar the skel dir before starting the notebook
COPY start-notebook.sh /usr/local/bin/start-notebook.sh

USER root
# Temporary in lieu of a better solution
RUN groupadd --gid 1001 project && \
    usermod -g 1001 jovyan
USER ${NB_UID}
