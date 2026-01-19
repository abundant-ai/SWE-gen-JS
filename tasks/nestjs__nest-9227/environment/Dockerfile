FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 16 (compatible with this codebase version)
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/nestjs/nest.git src && \
    cd src && \
    (git fetch --depth 1 origin 19ea1c2f359fa2e652daa664c706209452bb0a5a || git fetch --depth 1 origin "+refs/pull/9227/head:refs/remotes/origin/pr/9227") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Install dependencies using npm install (lock file out of sync at this commit)
RUN npm install --legacy-peer-deps

# Build TypeScript project
RUN npm run build

# If install/build steps touched tracked files, reset them so bug.patch applies cleanly,
RUN git reset --hard && git clean -fd

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Rebuild TypeScript after patching source files
RUN npm run build

# Create mocha setup file to configure chai-as-promised globally
RUN echo 'const chai = require("chai");\nconst chaiAsPromised = require("chai-as-promised");\nchai.use(chaiAsPromised);' > /app/src/mocha-setup.js

RUN rm -rf /app/src/.git

WORKDIR /app/src
