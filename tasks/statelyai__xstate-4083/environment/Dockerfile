FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 16 (from .node-version)
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Enable yarn via corepack
RUN corepack enable

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/statelyai/xstate.git src && \
    cd src && \
    (git fetch --depth 1 origin 92fe5949dadc080c9360afa59db68c75759480cf || git fetch --depth 1 origin "+refs/pull/4083/head:refs/remotes/origin/pr/4083") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Install dependencies with yarn
RUN yarn install --frozen-lockfile

# Build the TypeScript project
RUN yarn build

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Rebuild after applying bug.patch
RUN yarn build

RUN rm -rf /app/src/.git

WORKDIR /app/src