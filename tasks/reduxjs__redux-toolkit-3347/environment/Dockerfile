FROM ubuntu:24.04

# Base system packages (common to all languages)
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

# Enable yarn via corepack
RUN corepack enable

WORKDIR /app

# Configure git to preserve line endings
RUN git config --global core.autocrlf false

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/reduxjs/redux-toolkit.git src && \
    cd src && \
    (git fetch --depth 1 origin 3b14c077bc11a673daa61ed31641d4df47b6c8d6 || git fetch --depth 1 origin "+refs/pull/3347/head:refs/remotes/origin/pr/3347") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set environment variables
ENV CI=true

# Install dependencies
RUN yarn install

# Build the project
RUN yarn build

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN git apply --whitespace=fix /tmp/bug.patch && rm /tmp/bug.patch

# Rebuild after applying patch (TypeScript needs recompilation)
RUN yarn build

RUN rm -rf /app/src/.git

WORKDIR /app/src