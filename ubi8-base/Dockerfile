FROM quay.io/app-sre/ubi8-ubi:8.3

RUN dnf -y update && \
  dnf -y install \
    bzip2 \
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
  groupadd --gid 490 project && \
  useradd --home-dir /home/user --gid 490 --uid 490 user && \
  mkdir /home/project && \
  mkdir /home/scratch && \
  chown root:project /home/project /home/scratch && \
  chmod 775 /home/project /home/scratch
