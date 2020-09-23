ARG REGISTRY
FROM ${REGISTRY}/accord/centos7-base:latest

RUN yum -y --setopt=skip_missing_names_on_install=false install \
    R && \
  yum -y --setopt=skip_missing_names_on_install=false install \
    https://s3.amazonaws.com/rstudio-ide-build/server/centos6/x86_64/rstudio-server-rhel-1.4.861-x86_64.rpm && \
  yum clean all && \
  rm -rf /var/cache/yum && \
  chmod 1777 /var/run/rstudio-server
COPY database.conf /etc/rstudio/database.conf
