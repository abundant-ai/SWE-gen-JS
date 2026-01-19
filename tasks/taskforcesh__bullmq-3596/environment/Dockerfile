FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Additional base system packages
RUN apt-get update && apt-get install -y \
    python3-minimal \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 22.x (required by package.json engines)
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install Redis server (needed for tests)
RUN apt-get update && apt-get install -y redis-server && \
    rm -rf /var/lib/apt/lists/*

# Enable Yarn via corepack
RUN corepack enable

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/taskforcesh/bullmq.git src && \
    cd src && \
    (git fetch --depth 1 origin a6d49f2daa5d11a4415289d52b92aac7780df4c2 || git fetch --depth 1 origin "+refs/pull/3596/head:refs/remotes/origin/pr/3596") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

ENV CI=true
ENV NODE_ENV=test

# Install TypeScript/Node.js dependencies and build
RUN yarn install --frozen-lockfile
RUN yarn build

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Rebuild TypeScript after patching
RUN yarn build

RUN rm -rf /app/src/.git

WORKDIR /app/src