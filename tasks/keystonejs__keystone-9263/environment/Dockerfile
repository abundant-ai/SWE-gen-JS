FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 18
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Enable pnpm via corepack (this commit uses pnpm)
RUN corepack enable

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/keystonejs/keystone.git src && \
    cd src && \
    (git fetch --depth 1 origin f35a2a5f49137c2229d64403d1489c95d42fb5c8 || git fetch --depth 1 origin "+refs/pull/9263/head:refs/remotes/origin/pr/9263") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set environment variables
ENV CI=true
ENV PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1

# Install dependencies (skip optional dependencies to avoid postinstall failures)
RUN pnpm install --frozen-lockfile --ignore-scripts || pnpm install --frozen-lockfile

# Build the project (preconstruct build)
RUN pnpm build

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Rebuild after applying bug.patch (TypeScript needs recompilation)
RUN pnpm build

RUN rm -rf /app/src/.git

WORKDIR /app/src