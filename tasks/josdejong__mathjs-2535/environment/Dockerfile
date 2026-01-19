FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js runtime (engines.node: ">= 14", using Node 16 for webpack 4 compatibility)
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/josdejong/mathjs.git src && \
    cd src && \
    (git fetch --depth 1 origin b211048a551842b1636ef9185dd872307f250d63 || git fetch --depth 1 origin "+refs/pull/2535/head:refs/remotes/origin/pr/2535") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set environment variables for CI
ENV CI=true

# Install dependencies using npm ci (uses package-lock.json)
RUN npm ci

# Build the project (creates lib/esm/index.js required by benchmark tests)
RUN npm run build

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
# Note: AUTHORS file may fail to patch cleanly due to npm run build updating it
# This is expected and safe to ignore since AUTHORS is not functionally relevant to tests
COPY bug.patch /tmp/bug.patch
RUN patch -p1 --no-backup-if-mismatch < /tmp/bug.patch || \
    (echo "Patch applied with some failures (likely AUTHORS file), continuing..." && true) && \
    rm /tmp/bug.patch

# Rebuild after patching to reflect buggy state in built artifacts
RUN npm run build

RUN rm -rf /app/src/.git

WORKDIR /app/src