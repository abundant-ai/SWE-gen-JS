FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 22 (from .node-version)
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Enable pnpm via corepack
RUN corepack enable && corepack prepare pnpm@9.15.9 --activate

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/statelyai/xstate.git src && \
    cd src && \
    (git fetch --depth 1 origin c2ea8e35e23cf1a582824edc48bec29e2d63bf40 || git fetch --depth 1 origin "+refs/pull/5175/head:refs/remotes/origin/pr/5175") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Install dependencies with pnpm
RUN pnpm install --frozen-lockfile

# Build the TypeScript project (using preconstruct)
RUN pnpm build

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Rebuild after applying bug.patch (TypeScript requires rebuild)
RUN pnpm build

RUN rm -rf /app/src/.git

WORKDIR /app/src