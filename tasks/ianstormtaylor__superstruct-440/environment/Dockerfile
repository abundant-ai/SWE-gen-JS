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
    (git fetch --depth 1 origin a2d7e241f25d445a3e959c9897982ea43f361e96 || git fetch --depth 1 origin "+refs/pull/440/head:refs/remotes/origin/pr/440") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set CI environment variable
ENV CI=true

# Install dependencies with yarn
RUN yarn install --frozen-lockfile

# Build TypeScript to generate type definitions and compiled output
RUN yarn build:types && yarn build:cjs

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Rebuild after patching TypeScript source files
RUN yarn build:types && yarn build:cjs

RUN rm -rf /app/src/.git

WORKDIR /app/src