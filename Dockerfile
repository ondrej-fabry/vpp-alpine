FROM frolvlad/alpine-glibc

RUN apk add --no-cache \
    # required
    automake \
    bash \
    binutils \
    bsd-compat-headers \
    build-base \
    cmake \
    curl \
    findutils \
    gcc \
    git \
    libexecinfo-dev \
    linux-headers \
    make \
    musl-dev \
    openssl \
    patch \
    util-linux-dev \
    xz \
    # useful
    grep \
    mc \
    nano

RUN set -eux; \
    wget https://github.com/numactl/numactl/releases/download/v2.0.12/numactl-2.0.12.tar.gz; \
    tar -xzf numactl-2.0.12.tar.gz; \
    cd numactl-2.0.12; \
    ./configure; \
    make; \
    make install;

ARG VPP_REPO_URL=https://github.com/FDio/vpp.git
ARG VPP_COMMIT=""

RUN set -eux; \
    GIT_CLONE_ARGS=${GIT_CLONE_ARGS:-}; \
    [ -n "${VPP_COMMIT}" ] || GIT_CLONE_ARGS="--depth=1"; \
    git clone "${VPP_REPO_URL}" "${GIT_CLONE_ARGS}" /vpp; \
    cd /vpp; \
    [ -z "${VPP_COMMIT}" ] || git checkout "${VPP_COMMIT}"; \
    export UNATTENDED=y; \
    # install-dep does not work on Alpine
    touch ./build-root/.deps.ok; \
    make vpp_configure_args_vpp='--disable-japi' build || true; \
    # include <fcntl.h> in some files and try again
    sed -i '/#include "eal_filesystem.h"/a #include <fcntl.h>' ./build-root/build-vpp_debug-native/dpdk/dpdk-18.08/lib/librte_eal/linuxapp/eal/eal_hugepage_info.c; \
    sed -i '/#include "eal_filesystem.h"/a #include <fcntl.h>' ./build-root/build-vpp_debug-native/dpdk/dpdk-18.08/lib/librte_eal/linuxapp/eal/eal_memory.c; \
    make vpp_configure_args_vpp='--disable-japi' build;

# TBD

RUN bash

