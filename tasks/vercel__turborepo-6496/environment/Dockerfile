FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install additional system packages needed for turborepo build
RUN apt-get update && apt-get install -y \
    python3 \
    python3-pip \
    python3-venv \
    jq \
    capnproto \
    protobuf-compiler \
    cmake \
    pkg-config \
    libfreetype6-dev \
    libfontconfig1-dev \
    lld \
    clang \
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

# Configure Rust to use lld linker (faster and uses less memory than default ld)
RUN mkdir -p ~/.cargo && echo '[target.x86_64-unknown-linux-gnu]\nlinker = "clang"\nrustflags = ["-C", "link-arg=-fuse-ld=lld"]' > ~/.cargo/config.toml

# Install Go 1.20 (required by go.mod for building turbo CLI and protobuf generation)
RUN curl -fsSL https://go.dev/dl/go1.20.14.linux-amd64.tar.gz -o /tmp/go.tar.gz && \
    tar -C /usr/local -xzf /tmp/go.tar.gz && \
    rm /tmp/go.tar.gz
ENV PATH="/usr/local/go/bin:${PATH}"

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/vercel/turborepo.git src && \
    cd src && \
    (git fetch --depth 1 origin 59667f9b9fb4f1ede9a832f2388f4cfadd12abbc || git fetch --depth 1 origin "+refs/pull/6496/head:refs/remotes/origin/pr/6496") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set CI environment variable
ENV CI=true

# Install dependencies using pnpm
RUN pnpm install --frozen-lockfile

# Install Go dependencies (protoc-gen-go and protoc-gen-go-grpc for protobuf generation)
# Using versions compatible with Go 1.20
RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@v1.28.0 && \
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@v1.2.0
ENV PATH="/root/go/bin:${PATH}"

# Install the required Rust toolchain (rust-toolchain.toml specifies nightly-2024-08-30)
# This ensures the toolchain is available before internet access is disabled
RUN cargo --version

# Fetch all Rust dependencies to cache them before internet access is disabled
RUN cargo fetch

# Pre-compile the test binary for turbopack-ecmascript BEFORE applying bug patch
# This avoids OOM during test execution
RUN cargo test -p turbopack-ecmascript --lib --no-run

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Since we patched after compiling tests, we need to recompile the lib (not the full test binary)
# This should be fast since only the patched files need recompiling
RUN cargo build -p turbopack-ecmascript --lib

RUN rm -rf /app/src/.git

WORKDIR /app/src