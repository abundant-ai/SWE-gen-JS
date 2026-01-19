FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 20.x (from CI config)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Enable corepack for Yarn
RUN corepack enable

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/immerjs/immer.git src && \
    cd src && \
    (git fetch --depth 1 origin 0dbcfe7205cb0ffdb56170da74fba61d8337d15d || git fetch --depth 1 origin "+refs/pull/587/head:refs/remotes/origin/pr/587") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Install dependencies using Yarn
RUN yarn install --frozen-lockfile

# Build the project to generate dist/ directory with Flow types
RUN yarn build

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Rebuild after applying bug.patch to regenerate dist/ with buggy Flow types
RUN yarn install --frozen-lockfile && yarn build

RUN rm -rf /app/src/.git

WORKDIR /app/src