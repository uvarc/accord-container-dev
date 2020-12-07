FROM quay.io/accord/userpod-ubi8-base:latest

RUN dnf -y install R && \
  dnf -y install https://s3.amazonaws.com/rstudio-ide-build/desktop/centos8/x86_64/rstudio-1.4.1081-x86_64.rpm && \
  yum clean all && \
  rm -rf /var/cache/yum && \
  chmod 1777 /var/run/rstudio-server
COPY database.conf /etc/rstudio/database.conf
