FROM quay.io/accord/centos8-base:latest

RUN dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm && \
  dnf install dnf-plugins-core && \
  dnf config-manager --set-enabled PowerTools && \
  dnf -y install R && \
  dnf -y install https://s3.amazonaws.com/rstudio-ide-build/desktop/centos8/x86_64/rstudio-1.4.1081-x86_64.rpm && \
  dnf clean all && \
  rm -rf /var/cache /var/log/dnf* /var/log/dnf.* && \
  chmod 1777 /var/run/rstudio-server
COPY database.conf /etc/rstudio/database.conf
