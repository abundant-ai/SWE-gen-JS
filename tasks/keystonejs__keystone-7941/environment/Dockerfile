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

# Enable Yarn Classic 1.x (this commit uses Yarn v1 lockfile)
RUN npm install -g yarn@1.22.22

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/keystonejs/keystone.git src && \
    cd src && \
    (git fetch --depth 1 origin 93c16e567fad1047d2482be0589493bd726fb85e || git fetch --depth 1 origin "+refs/pull/7941/head:refs/remotes/origin/pr/7941") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set environment variables
ENV CI=true
ENV PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1

# Install dependencies
RUN yarn install --frozen-lockfile

# Build the project (preconstruct build)
RUN yarn build

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Rebuild after applying bug.patch (TypeScript needs recompilation)
RUN yarn build

RUN rm -rf /app/src/.git

WORKDIR /app/src