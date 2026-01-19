FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 16 (required for compatibility)
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/TypeStrong/ts-node.git src && \
    cd src && \
    (git fetch --depth 1 origin 59c6ad2cc348b284ff85f64649d4f5f50f8f8a2a || git fetch --depth 1 origin "+refs/pull/395/head:refs/remotes/origin/pr/395") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

ENV CI=true

# Install dependencies
RUN npm install --legacy-peer-deps --ignore-scripts

# Build (may have type errors but that's okay for base state)
RUN npm run build || true

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Reinstall dependencies after patch (package.json may have changed)
RUN npm install --legacy-peer-deps --ignore-scripts

# Rebuild after applying bug.patch (may have type errors but that's okay for base state)
RUN npm run build || true

RUN rm -rf /app/src/.git

WORKDIR /app/src