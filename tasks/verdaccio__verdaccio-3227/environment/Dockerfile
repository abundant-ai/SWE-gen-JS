FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    python3 \
    python3-setuptools \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 16 (from .nvmrc)
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Enable corepack for pnpm
RUN corepack enable && corepack prepare pnpm@6.35.1 --activate

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/verdaccio/verdaccio.git src && \
    cd src && \
    (git fetch --depth 1 origin bbad8a2290162614b06d21ffa3f88df067324187 || git fetch --depth 1 origin "+refs/pull/3227/head:refs/remotes/origin/pr/3227") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set CI environment variable
ENV CI=true

# Remove .npmrc to avoid custom registry issues during Docker build
RUN rm -f .npmrc

# Install dependencies with pnpm
RUN pnpm install --frozen-lockfile || true

# Build the TypeScript project (may have some failures but continue)
RUN pnpm run build || true

# If install/build steps touched tracked files, reset them so bug.patch applies cleanly,
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch || true
RUN rm /tmp/bug.patch

# Manually remove binary file that patch couldn't handle
RUN rm -f .yarn/cache/@verdaccio-scope-verdaccio-auth-foo-npm-0.0.2-e8d6fdf0d9-99f4727a67.zip

# Save a copy of the binary file for later restoration by test script
RUN mkdir -p /tmp/yarn-binary-cache && \
    git checkout HEAD -- .yarn/cache/@verdaccio-scope-verdaccio-auth-foo-npm-0.0.2-e8d6fdf0d9-99f4727a67.zip 2>/dev/null || true && \
    cp .yarn/cache/@verdaccio-scope-verdaccio-auth-foo-npm-0.0.2-e8d6fdf0d9-99f4727a67.zip /tmp/yarn-binary-cache/ 2>/dev/null || true && \
    rm -f .yarn/cache/@verdaccio-scope-verdaccio-auth-foo-npm-0.0.2-e8d6fdf0d9-99f4727a67.zip

# Remove .npmrc to avoid custom registry issues during Docker build
RUN rm -f .npmrc

# Reinstall dependencies after patch (package.json and pnpm-lock.yaml changed)
RUN pnpm install --frozen-lockfile || pnpm install

# Rebuild after patching TypeScript source (may fail if patch introduces compile errors)
RUN pnpm run build || true

RUN rm -rf /app/src/.git

WORKDIR /app/src
