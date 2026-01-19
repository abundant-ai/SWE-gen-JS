FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install additional base packages
RUN apt-get update && apt-get install -y \
    python3 \
    python3-setuptools \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 16 (from .nvmrc)
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Enable corepack for pnpm
RUN corepack enable && corepack prepare pnpm@6.35.1 --activate

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/verdaccio/verdaccio.git src && \
    cd src && \
    (git fetch --depth 1 origin 28069fb0734c9316bc772cbd61605f8c547c546d || git fetch --depth 1 origin "+refs/pull/2292/head:refs/remotes/origin/pr/2292") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set CI environment variable
ENV CI=true

# Remove .npmrc to avoid custom registry issues during Docker build
RUN rm -f .npmrc

# Install dependencies with pnpm
RUN pnpm install --frozen-lockfile || true

# Build the TypeScript project (may have some failures but continue)
RUN pnpm run build || true

# If install/build steps touched tracked files, reset them so bug.patch applies cleanly,
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch || true
RUN rm /tmp/bug.patch

# Remove .npmrc to avoid custom registry issues during Docker build
RUN rm -f .npmrc

# Reinstall dependencies after patch (package.json and pnpm-lock.yaml may have changed)
RUN pnpm install --frozen-lockfile || pnpm install

# Rebuild after patching TypeScript source (may fail if patch introduces compile errors)
RUN pnpm run build || true

RUN rm -rf /app/src/.git

WORKDIR /app/src
