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
    (git fetch --depth 1 origin 5f6cdfa4bc139a9b538086bd0083533b5d6f6fe6 || git fetch --depth 1 origin "+refs/pull/921/head:refs/remotes/origin/pr/921") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

ENV CI=true

# Install dependencies
RUN npm install --legacy-peer-deps --ignore-scripts

# Build TypeScript
RUN npm run build

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN (patch -p1 --force --reject-file=/dev/null < /tmp/bug.patch || true) && rm /tmp/bug.patch

# Reinstall dependencies after patch (package.json and package-lock.json changed)
RUN npm install --legacy-peer-deps --ignore-scripts

# Rebuild after applying bug.patch
RUN npm run build

RUN rm -rf /app/src/.git

WORKDIR /app/src