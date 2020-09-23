ARG REGISTRY
FROM ${REGISTRY}/accord/theia-jupyter-base:latest

LABEL maintainer=khs3z@virginia.edu

USER root

ENV HTSLIB_VERSION=1.10.2
ENV BCFTOOLS_VERSION=1.10.2
ENV LD_LIBRARY_PATH=/opt/htslib/${HTSLIB_VERSION}/lib:$LD_LIBRARY_PATH
ENV PATH=/opt/htslib/${HTSLIB_VERSION}/bin:$PATH
ENV PATH=/opt/bcftools/${BCFTOOLS_VERSION}/bin:$PATH

RUN yum install -y \
        make gmp-devel mpfr-devel libmpc-devel gcc gcc-c++ g++ \
        openssl-devel \
        autoheader \
        autoconf \
        perl \
        ncurses-devel \
        libcurl-devel \
        libcrypto \
        zlib-devel \
        bzip2 \ 
        bzip2-devel \
        xz-devel \
        gsl-devel \
        perl-Data-Dumper gsl-devel \
        perl-ExtUtils-Embed \
        wget && \
    yum -y clean all && rm -rf /var/cache/yum && \

    wget https://github.com/samtools/htslib/archive/${HTSLIB_VERSION}.tar.gz && \
    tar xzf ${HTSLIB_VERSION}.tar.gz && \
    cd htslib-${HTSLIB_VERSION} && \
    autoheader && \
    autoconf -Wno-syntax && \
    ./configure --prefix=/opt/htslib/${HTSLIB_VERSION} && \
    make && \
    make install && \
    cd .. && \
    rm ${HTSLIB_VERSION}.tar.gz && \
    rm -rf htslib-${HTSLIB_VERSION} && \

    wget https://github.com/samtools/bcftools/archive/${BCFTOOLS_VERSION}.tar.gz && \
    tar xzf ${BCFTOOLS_VERSION}.tar.gz && \
    cd bcftools-${BCFTOOLS_VERSION} && \
    autoheader && \
    autoconf -Wno-syntax && \
    ./configure \
        --prefix=/opt/bcftools/${BCFTOOLS_VERSION} \
        --enable-perl-filters \
        --enable-libgsl \
        --with-htslib=/opt/htslib/${HTSLIB_VERSION} && \        
    make && \
    make install && \
    cd .. && \
    rm ${BCFTOOLS_VERSION}.tar.gz && \
    rm -rf bcftools-${BCFTOOLS_VERSION}

ENTRYPOINT ["/bin/bash", "-l"]
