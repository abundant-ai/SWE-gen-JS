FROM ubuntu:24.04

# Base system packages
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 16 (required for compatibility with TypeScript 2.4 and old packages)
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/TypeStrong/ts-node.git src && \
    cd src && \
    (git fetch --depth 1 origin 2dcfc3cd84563c52030d52913d16881aa272b77d || git fetch --depth 1 origin "+refs/pull/413/head:refs/remotes/origin/pr/413") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

ENV CI=true

# Install dependencies (use --ignore-scripts to skip prepublish hook)
RUN npm install --legacy-peer-deps --ignore-scripts

# Install compatible @types versions for TypeScript 2.4
RUN npm install --legacy-peer-deps --ignore-scripts \
    @types/node@8.0.27 \
    @types/chai@4.0.4 \
    @types/mocha@2.2.42 \
    @types/chalk@0.4.31

# Remove chalk's built-in types (incompatible with TypeScript 2.4)
RUN rm -rf node_modules/chalk/types

# Build TypeScript
RUN npm run build

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
# Bug.patch reverts type-related changes that break TypeScript compilation
# We keep the dist/ from HEAD since the CLI is the same - the bug affects type exports
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

RUN rm -rf /app/src/.git

WORKDIR /app/src