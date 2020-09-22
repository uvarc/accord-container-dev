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
    python3 \
    python3-pip \
    unzip \
    vim-minimal \
    which && \
  yum clean all && \
  rm -rf /var/cache/yum && \
  groupadd --gid 490 project && \
  useradd --gid 490 --uid 490 user && \
  mkdir /project && \
  mkdir /scratch && \
  chown user:project /project /scratch
