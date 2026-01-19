FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 18.x (LTS)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Enable corepack for yarn
RUN corepack enable

# Set Node.js to use legacy OpenSSL provider (needed for older webpack versions)
ENV NODE_OPTIONS=--openssl-legacy-provider

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/ohmjs/ohm.git src && \
    cd src && \
    (git fetch --depth 1 origin f3ea8429a86edd33694a08922ac6adb8d19098b3 || git fetch --depth 1 origin "+refs/pull/267/head:refs/remotes/origin/pr/267") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Install dependencies with yarn
RUN yarn install --frozen-lockfile

# Build the project
RUN yarn build

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Rebuild after patching
RUN yarn build

RUN rm -rf /app/src/.git

WORKDIR /app/src