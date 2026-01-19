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

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/supabase/supabase-js.git src && \
    cd src && \
    (git fetch --depth 1 origin eb0c79919aa1933fb4b7fba551caf92d6ce3c974 || git fetch --depth 1 origin "+refs/pull/1829/head:refs/remotes/origin/pr/1829") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set environment variables for CI
ENV CI=true

# If install/build steps touched tracked files, reset them so bug.patch applies cleanly
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Install dependencies using npm ci (frozen lockfile)
RUN npm ci

# Build TypeScript packages (nx-based monorepo)
RUN npx nx run-many --target=build --all

RUN rm -rf /app/src/.git

WORKDIR /app/src
