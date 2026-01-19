FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 20 (from .nvmrc)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Enable corepack for pnpm
RUN corepack enable && corepack prepare pnpm@10.5.2 --activate

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/verdaccio/verdaccio.git src && \
    cd src && \
    (git fetch --depth 1 origin 7191fb7d66d4ee7f46e98a92d28dd9168cffee63 || git fetch --depth 1 origin "+refs/pull/4716/head:refs/remotes/origin/pr/4716") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set CI environment variable
ENV CI=true

# Install dependencies with pnpm
RUN pnpm install --frozen-lockfile

# Build the TypeScript project
RUN pnpm build

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
# Binary file deletion needs manual handling - delete it first, then patch will skip over it
RUN rm -f packages/middleware/test/config/favicon.ico
COPY bug.patch /tmp/bug.patch
RUN (patch -p1 --force --forward < /tmp/bug.patch || true) && rm /tmp/bug.patch

# Rebuild after patching TypeScript source
RUN pnpm build

RUN rm -rf /app/src/.git

WORKDIR /app/src