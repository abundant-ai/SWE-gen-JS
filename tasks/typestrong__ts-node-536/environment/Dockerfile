FROM ubuntu:24.04

# Base system packages
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 16 (older version needed for compatibility with old packages)
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/TypeStrong/ts-node.git src && \
    cd src && \
    (git fetch --depth 1 origin 68687e165b6883fb95d8b4ceb7d4326d8d7fdba6 || git fetch --depth 1 origin "+refs/pull/536/head:refs/remotes/origin/pr/536") && \
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

# Reinstall dependencies after applying bug.patch (package.json changed)
# Use --ignore-scripts to skip the prepublish hook that tries to build with incompatible @types/node
RUN npm install --legacy-peer-deps --ignore-scripts

# Remove the incompatible @types/node and install a compatible version (for TypeScript 2.4)
RUN rm -rf node_modules/@types/node && npm install --legacy-peer-deps --ignore-scripts @types/node@8.0.27

# Rebuild after applying bug.patch (TypeScript needs rebuild)
RUN npm run build

RUN rm -rf /app/src/.git

WORKDIR /app/src