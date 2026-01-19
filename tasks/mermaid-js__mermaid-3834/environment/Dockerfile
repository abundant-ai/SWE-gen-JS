FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 16.x (mermaid at this commit needs an older Node.js for ts-node compatibility)
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Enable corepack for pnpm (mermaid uses pnpm)
RUN corepack enable

WORKDIR /app

# Configure git to handle line endings properly for patching
RUN git config --global core.autocrlf false

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/mermaid-js/mermaid.git src && \
    cd src && \
    (git fetch --depth 1 origin c781545a40860c1bb186ac38465c0b41e28ecedb || git fetch --depth 1 origin "+refs/pull/3834/head:refs/remotes/origin/pr/3834") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set CI environment variable
ENV CI=true

# Install dependencies (ignore scripts to avoid prepare hook issues)
RUN pnpm install --frozen-lockfile --ignore-scripts

# Build packages
RUN pnpm run build

# Normalize line endings for files that will be patched (CRLF -> LF)
RUN apt-get update && apt-get install -y dos2unix && rm -rf /var/lib/apt/lists/* && \
    dos2unix .github/pull_request_template.md

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Note: We do NOT rebuild after applying bug.patch because the patch introduces
# build-breaking changes (adds frontmatter.ts that imports js-yaml without adding
# it to dependencies, plus other structural changes). The tests will run against
# the pre-patch build artifacts, which is sufficient for test execution.

RUN rm -rf /app/src/.git

WORKDIR /app/src