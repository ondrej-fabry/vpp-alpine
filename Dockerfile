FROM frolvlad/alpine-glibc

RUN apk add --no-cache \
    automake \
    bash \
    bsd-compat-headers \
    build-base \
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
    util-linux-dev

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
    git clone "${VPP_REPO_URL}" vpp; \
    cd vpp; \
    [ -z "${VPP_COMMIT}" ] || git checkout "${VPP_COMMIT}"; \
    export UNATTENDED=y; \
    # install-dep does not work on Alpine
    touch ./build-root/.deps.ok; \
    make vpp_configure_args_vpp='--disable-japi' build; \
    cd build-root; \
    rm -rf .ccache /var/lib/apt/lists/*; \
    find . -type f -name '*.o' -exec rm -rf '{}' \;

# TBD
