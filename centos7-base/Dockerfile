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
  useradd --home-dir /home/homedir --gid 490 --uid 490 user && \
  mkdir /home/project && \
  mkdir /home/scratch && \
  chown root:project /home/project /home/scratch && \
  chmod 775 /home/project /home/scratch
