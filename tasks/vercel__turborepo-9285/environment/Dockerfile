FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    python3 \
    python3-pip \
    python3-venv \
    jq \
    capnproto \
    protobuf-compiler \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 22.x (required by package.json engines field)
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Set up pnpm package manager
RUN corepack enable && corepack prepare pnpm@10.25.0 --activate

# Install Rust (required for building native modules)
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
ENV PATH="/root/.cargo/bin:${PATH}"

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/vercel/turborepo.git src && \
    cd src && \
    (git fetch --depth 1 origin 5d2cbab394a645fbb8e1ce3a52ea4cbdc9268368 || git fetch --depth 1 origin "+refs/pull/9285/head:refs/remotes/origin/pr/9285") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set CI environment variable
ENV CI=true

# Install dependencies using pnpm
RUN pnpm install --frozen-lockfile

# Install the required Rust toolchain (rust-toolchain.toml specifies nightly-2024-08-30)
# This ensures the toolchain is available before internet access is disabled
RUN cargo --version

# Fetch all Rust dependencies to cache them before internet access is disabled
RUN cargo fetch

# Build the turbo binary (required for integration tests)
RUN cargo build --bin turbo

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

RUN rm -rf /app/src/.git

WORKDIR /app/src