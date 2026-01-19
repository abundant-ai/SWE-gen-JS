FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 16 (per .nvmrc)
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Enable pnpm via corepack
RUN corepack enable

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/TanStack/query.git src && \
    cd src && \
    (git fetch --depth 1 origin d750bd1b246d38d68f026eff6917f76818c69ed6 || git fetch --depth 1 origin "+refs/pull/6043/head:refs/remotes/origin/pr/6043") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set environment variables
ENV CI=true
ENV NX_NO_CLOUD=true

# Install dependencies
RUN pnpm install

# Build the project
RUN pnpm run build

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Reset NX cache to avoid cache integrity issues after patching
RUN npx nx reset

# Rebuild after applying bug.patch (TypeScript needs recompilation)
RUN pnpm run build

RUN rm -rf /app/src/.git

WORKDIR /app/src