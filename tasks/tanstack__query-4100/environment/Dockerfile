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
    (git fetch --depth 1 origin e7803f1b0fc872af76de635ed6e5303d4db20c30 || git fetch --depth 1 origin "+refs/pull/4100/head:refs/remotes/origin/pr/4100") && \
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
RUN pnpm add -D babel-jest@^27.5.1 -w

# Install use-sync-external-store (required by react-query)
RUN pnpm add use-sync-external-store -w

# Mock superjson module for jest to avoid ES module issues
RUN mkdir -p __mocks__ && \
    echo "const superjson = { \
  stringify: (v) => JSON.stringify(v), \
  parse: (v) => JSON.parse(v), \
  serialize: (v) => ({ json: v, meta: undefined }), \
  deserialize: (v) => v.json \
}; \
module.exports = superjson; \
module.exports.default = superjson;" > __mocks__/superjson.js

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

RUN rm -rf /app/src/.git

WORKDIR /app/src