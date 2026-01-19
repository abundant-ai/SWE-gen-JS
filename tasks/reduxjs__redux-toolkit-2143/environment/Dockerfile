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

# Install dos2unix for patch handling
RUN apt-get update && apt-get install -y dos2unix && rm -rf /var/lib/apt/lists/*

# Enable yarn via corepack
RUN corepack enable

WORKDIR /app

# Configure git to preserve line endings
RUN git config --global core.autocrlf false

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/reduxjs/redux-toolkit.git src && \
    cd src && \
    (git fetch --depth 1 origin 4ec7b53c67ea736e1e6e03450a523561d458bead || git fetch --depth 1 origin "+refs/pull/2143/head:refs/remotes/origin/pr/2143") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set environment variables
ENV CI=true

# Install dependencies
RUN yarn install

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN dos2unix /tmp/bug.patch && \
    patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Reinstall dependencies (patch may change package.json)
RUN yarn install

RUN rm -rf /app/src/.git

WORKDIR /app/src