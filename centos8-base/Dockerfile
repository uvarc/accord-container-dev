FROM registry.centos.org/centos:8

ADD http://worldtimeapi.org/api/timezone/Etc/UTC.txt /timestamp

RUN chmod 0644 /timestamp && \
  dnf -y update && \
  dnf -y install \
    bzip2 \
    gcc \
    gcc-c++ \
    git \
    jq \
    less \
    make \
    patch \
    python3 \
    python3-pip \
    unzip \
    vim-minimal \
    which \
    xz && \
  dnf clean all && \
  rm -rf /var/cache /var/log/dnf* /var/log/dnf.* && \
  groupadd --gid 490 user && \
  groupadd --gid 491 project && \
  useradd --home-dir /home/user --uid 490 --gid 490 user && \
  mkdir /home/project && \
  mkdir /home/scratch && \
  chown root:project /home/project /home/scratch && \
  chmod 775 /home/project /home/scratch
