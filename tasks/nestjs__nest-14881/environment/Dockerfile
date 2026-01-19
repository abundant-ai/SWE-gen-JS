FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 20 (required by package.json engines field)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/nestjs/nest.git src && \
    cd src && \
    (git fetch --depth 1 origin dcc177a133c51f0a23a98667f7e23209a8327531 || git fetch --depth 1 origin "+refs/pull/14881/head:refs/remotes/origin/pr/14881") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Install dependencies using npm install (lock file out of sync at this commit)
RUN npm install --legacy-peer-deps

# Build TypeScript project
RUN npm run build

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 --binary < /tmp/bug.patch || true && \
    rm -f sample/29-file-upload/resources/nestjs.jpg && \
    rm /tmp/bug.patch

# Fix error message mismatch at HEAD commit (dcc177a133 has "current" but tests expect "detected")
RUN sed -i 's/current file type/detected file type/g' packages/common/pipes/file/file-type.validator.ts

# Rebuild TypeScript after patching source files
RUN npm run build

RUN rm -rf /app/src/.git

WORKDIR /app/src