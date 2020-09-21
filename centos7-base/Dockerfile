FROM centos:7.8.2003

RUN yum -y --setopt=skip_missing_names_on_install=false install epel-release && \
  yum -y update && \
  yum -y --setopt=skip_missing_names_on_install=false install "https://repo.ius.io/ius-release-el7.rpm" && \
  yum -y --setopt=skip_missing_names_on_install=false install \
    bzip2 \
    git224 \
    jq \
    less \
    make \
    patch \
    unzip \
    vim-minimal \
    which && \
  yum clean all && \
  rm -rf /var/cache/yum
