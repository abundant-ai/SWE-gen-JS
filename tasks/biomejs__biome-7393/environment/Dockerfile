FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Rust toolchain (version 1.90.0 as specified in rust-toolchain.toml)
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain 1.90.0
ENV PATH="/root/.cargo/bin:${PATH}"

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/biomejs/biome.git src && \
    cd src && \
    (git fetch --depth 1 origin a39311004963a8e21552ba2d78c0ff0945de130f || git fetch --depth 1 origin "+refs/pull/7393/head:refs/remotes/origin/pr/7393") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

ENV RUST_BACKTRACE=1

# Configure cargo to reduce memory usage during linking
RUN mkdir -p /root/.cargo && echo '[profile.dev]\nsplit-debuginfo = "unpacked"' >> /root/.cargo/config.toml

# Fetch dependencies (speeds up later builds)
RUN cargo fetch

# Build the test binaries for the packages we need to test
# This must be done BEFORE applying bug.patch to avoid OOM during linking
RUN cargo test --no-run -p biome_js_type_info -p biome_module_graph

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

RUN rm -rf /app/src/.git

WORKDIR /app/src