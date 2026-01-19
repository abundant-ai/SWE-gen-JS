FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 22 (per .nvmrc)
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Enable pnpm via corepack
RUN corepack enable

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/TanStack/query.git src && \
    cd src && \
    (git fetch --depth 1 origin 9ee8ded0c548b1910bb90cd180e29d4cfd9e684c || git fetch --depth 1 origin "+refs/pull/8925/head:refs/remotes/origin/pr/8925") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set environment variables
ENV CI=true
ENV NX_NO_CLOUD=true

# Install dependencies
RUN pnpm install

# Build the project
RUN pnpm run build:all

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Rebuild after applying bug.patch (TypeScript needs recompilation)
RUN pnpm run build:all

RUN rm -rf /app/src/.git

WORKDIR /app/src