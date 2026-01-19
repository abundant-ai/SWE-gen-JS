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

# Enable corepack for yarn
RUN corepack enable && corepack prepare yarn@4.1.0 --activate

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/verdaccio/verdaccio.git src && \
    cd src && \
    (git fetch --depth 1 origin b842824b48e24abce097d6f4bc97d8681398381b || git fetch --depth 1 origin "+refs/pull/4643/head:refs/remotes/origin/pr/4643") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set CI environment variable
ENV CI=true

# Install dependencies with yarn
RUN yarn install --immutable

# Build the TypeScript project
RUN yarn build

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Reinstall dependencies after patch (package.json and yarn.lock changed)
RUN yarn install --immutable

# Rebuild after patching TypeScript source
RUN yarn build

RUN rm -rf /app/src/.git

WORKDIR /app/src