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

# Install Node.js 22.x (mermaid uses Node.js)
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Enable corepack for pnpm (mermaid uses pnpm)
RUN corepack enable

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/mermaid-js/mermaid.git src && \
    cd src && \
    (git fetch --depth 1 origin eb4a6fd2ed26baa36ee2cb7ea795345ea1331f4d || git fetch --depth 1 origin "+refs/pull/5173/head:refs/remotes/origin/pr/5173") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set CI environment variable
ENV CI=true

# Install dependencies
RUN pnpm install --frozen-lockfile

# Build mermaid (TypeScript project)
RUN pnpm run build

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Rebuild after applying bug.patch (TypeScript needs rebuild)
RUN pnpm run build

RUN rm -rf /app/src/.git

WORKDIR /app/src