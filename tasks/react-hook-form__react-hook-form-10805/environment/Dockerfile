FROM ubuntu:24.04

# Base system packages
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 18.x (package.json requires node >= 12.22.0, using 18 for pnpm v7 compatibility)
RUN curl -fsSL https://deb.nodesource.com/setup_18.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Enable corepack and set up pnpm v7 (package.json packageManager = "pnpm@7.18.0")
RUN corepack enable && corepack prepare pnpm@7.18.0 --activate

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/react-hook-form/react-hook-form.git src && \
    cd src && \
    (git fetch --depth 1 origin e0fbf943e4c93fc8dc9650067bef2fa8dc94b765 || git fetch --depth 1 origin "+refs/pull/10805/head:refs/remotes/origin/pr/10805") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set CI=true to avoid interactive prompts
ENV CI=true

# Install dependencies
RUN pnpm install

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

RUN rm -rf /app/src/.git

WORKDIR /app/src