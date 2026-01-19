FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js (project requires >=14.0.0, using LTS 20.x)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Enable corepack for yarn
RUN corepack enable

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/ianstormtaylor/superstruct.git src && \
    cd src && \
    (git fetch --depth 1 origin 19bb9a2ae57e17de6c39a76632e75e234327d640 || git fetch --depth 1 origin "+refs/pull/65/head:refs/remotes/origin/pr/65") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set CI environment variable
ENV CI=true

# Install dependencies with yarn
RUN yarn install --frozen-lockfile

# Build project to generate compiled output
RUN yarn build:cjs

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Rebuild after patching source files
RUN yarn build:cjs

RUN rm -rf /app/src/.git

WORKDIR /app/src