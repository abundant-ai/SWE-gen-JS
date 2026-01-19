FROM ubuntu:24.04

# Base system packages
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

WORKDIR /app

# Clone repo at HEAD commit (already in buggy BASE state with --cwd-mode)
RUN git clone https://github.com/TypeStrong/ts-node.git src && \
    cd src && \
    (git fetch --depth 1 origin 647a9f1e738d94783e2a1eaf3b7ac3a41d28ea4e || git fetch --depth 1 origin "+refs/pull/1155/head:refs/remotes/origin/pr/1155") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set environment variables
ENV CI=true

# Install dependencies (--legacy-peer-deps for npm 7+ compatibility)
RUN npm ci --legacy-peer-deps

# Build TypeScript
RUN npm run build

RUN rm -rf /app/src/.git

WORKDIR /app/src