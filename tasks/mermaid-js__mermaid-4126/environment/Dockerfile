FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Cypress dependencies for headless browser testing
RUN apt-get update && apt-get install -y \
    xvfb \
    libgtk-3-0t64 \
    libgbm1 \
    libnotify4 \
    libnss3 \
    libxss1 \
    libasound2t64 \
    libxtst6 \
    xauth \
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
    (git fetch --depth 1 origin c8e351c2bba934aab67e8d2e441a7bde5146dae0 || git fetch --depth 1 origin "+refs/pull/4126/head:refs/remotes/origin/pr/4126") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set CI environment variable
ENV CI=true

# Install dependencies (ignore scripts to avoid prepare hook issues)
RUN pnpm install --frozen-lockfile --ignore-scripts

# Install Cypress binary
RUN npx cypress install

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

# Reinstall dependencies after bug.patch (patches package.json and pnpm-lock.yaml)
RUN pnpm install --frozen-lockfile --ignore-scripts

# Rebuild after applying bug.patch
RUN pnpm run build

RUN rm -rf /app/src/.git

WORKDIR /app/src