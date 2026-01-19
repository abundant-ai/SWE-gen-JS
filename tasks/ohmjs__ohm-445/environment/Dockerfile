FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 20.x
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install pnpm v7 (compatible with lockfileVersion 5.4)
RUN npm install -g pnpm@7

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/ohmjs/ohm.git src && \
    cd src && \
    (git fetch --depth 1 origin a67a555ba6011d39c0978ca7c23cae9d14a41c39 || git fetch --depth 1 origin "+refs/pull/445/head:refs/remotes/origin/pr/445") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Install dependencies with pnpm
RUN pnpm install --frozen-lockfile

# Build the project
RUN pnpm build

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Rebuild after patching
RUN pnpm build

RUN rm -rf /app/src/.git

WORKDIR /app/src