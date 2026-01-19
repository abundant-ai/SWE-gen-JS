FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 18
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Enable pnpm via corepack
RUN corepack enable

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/TanStack/query.git src && \
    cd src && \
    (git fetch --depth 1 origin e5ab2782c07eb9dc61daab35dc8b3da0ce8bd16a || git fetch --depth 1 origin "+refs/pull/4177/head:refs/remotes/origin/pr/4177") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set environment variables
ENV CI=true
ENV NX_NO_CLOUD=true

# Remove incompatible patchedDependencies from package.json
RUN sed -i '/"patchedDependencies":/,/}/d' package.json

# Install dependencies
RUN pnpm install --no-frozen-lockfile

# Install jsdom as devDependency (required for jest jsdom environment)
RUN pnpm add -D jsdom --filter @tanstack/query-core

# Install babel-jest as devDependency (required for jest typescript transformation)
RUN pnpm add -D babel-jest@^27.5.1

# Install use-sync-external-store (required by react-query)
RUN pnpm add use-sync-external-store

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

RUN rm -rf /app/src/.git

WORKDIR /app/src