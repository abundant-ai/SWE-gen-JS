FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Rust toolchain (version 1.91.1 as specified in rust-toolchain.toml)
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain 1.91.1
ENV PATH="/root/.cargo/bin:${PATH}"

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/biomejs/biome.git src && \
    cd src && \
    (git fetch --depth 1 origin c419b89a430dd6872ba20943f7da4f6c9a7d4dc5 || git fetch --depth 1 origin "+refs/pull/8501/head:refs/remotes/origin/pr/8501") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

ENV RUST_BACKTRACE=1

# Fetch dependencies (speeds up later builds)
RUN cargo fetch

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Build after applying bug.patch (may have compilation errors in buggy state, hence || true)
RUN cargo test --no-run --workspace || true

RUN rm -rf /app/src/.git

WORKDIR /app/src