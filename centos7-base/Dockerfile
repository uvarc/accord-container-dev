FROM centos:7.8.2003

RUN yum -y install epel-release && \
  yum -y update && \
  yum -y install "https://repo.ius.io/ius-release-el7.rpm" && \
  yum -y install \
    bzip2 \
    git2u-all \
    jq \
    less \
    make \
    patch \
    openssh \
    unzip \
    vim-minimal \
    which && \
  yum clean all && \
  rm -rf /var/cache/yum
