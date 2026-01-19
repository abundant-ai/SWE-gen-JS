FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 20 (required by package.json engines.node: ">=20")
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Enable corepack for Yarn (package manager is yarn@4.12.0)
RUN corepack enable

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/prettier/prettier.git src && \
    cd src && \
    (git fetch --depth 1 origin 89698eedf0eac74b1a714556df1b5776b5c1555d || git fetch --depth 1 origin "+refs/pull/17077/head:refs/remotes/origin/pr/17077") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Install dependencies with frozen lockfile
RUN yarn install --immutable

# Build the project (creates dist/ directory with bundled code)
RUN yarn build

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Reinstall dependencies after patch (patch modifies package.json and yarn.lock)
RUN yarn install --immutable

# Rebuild after patching source files
RUN yarn build

RUN rm -rf /app/src/.git

WORKDIR /app/src