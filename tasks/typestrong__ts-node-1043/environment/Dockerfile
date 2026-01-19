FROM ubuntu:24.04

# Base system packages
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

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/TypeStrong/ts-node.git src && \
    cd src && \
    (git fetch --depth 1 origin 2f620a9e5e4a0383ec40ab643522d935f69c508d || git fetch --depth 1 origin "+refs/pull/1043/head:refs/remotes/origin/pr/1043") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set environment variables
ENV CI=true

# Install dependencies (--legacy-peer-deps for npm 7+ compatibility)
RUN npm ci --legacy-peer-deps

# Build TypeScript
RUN npm run build

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Rebuild after applying bug.patch (TypeScript needs rebuild)
RUN npm run build

RUN rm -rf /app/src/.git

WORKDIR /app/src