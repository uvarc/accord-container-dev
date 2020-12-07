FROM quay.io/accord/centos8-base:latest

RUN dnf -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm && \
  dnf -y install dnf-plugins-core && \
  dnf config-manager --set-enabled powertools && \
  dnf -y install R && \
  dnf -y install https://s3.amazonaws.com/rstudio-ide-build/server/centos8/x86_64/rstudio-server-rhel-1.4.1082-x86_64.rpm && \
  dnf clean all && \
  rm -rf /var/cache /var/log/dnf* /var/log/dnf.* && \
  chmod 1777 /var/run/rstudio-server
COPY database.conf /etc/rstudio/database.conf
