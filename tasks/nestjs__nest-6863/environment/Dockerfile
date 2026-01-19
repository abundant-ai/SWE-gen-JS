FROM ubuntu:22.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    python3 \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 16 (compatible with this codebase version)
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/nestjs/nest.git src && \
    cd src && \
    (git fetch --depth 1 origin e068c08b99e83d57a374b1f514bca3e450171b9a || git fetch --depth 1 origin "+refs/pull/6863/head:refs/remotes/origin/pr/6863") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Install dependencies
RUN npm install --legacy-peer-deps

# Build packages (creates packages in node_modules/@nestjs/ with fixed code)
RUN npm run build

# If install/build steps touched tracked files, reset them so bug.patch applies cleanly,
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Rebuild after applying bug.patch (critical for TypeScript changes to take effect)
RUN npm run build

# Create mocha setup file to configure chai-as-promised globally
RUN echo 'const chai = require("chai");\nconst chaiAsPromised = require("chai-as-promised");\nchai.use(chaiAsPromised);' > /app/src/mocha-setup.js

RUN rm -rf /app/src/.git

WORKDIR /app/src
