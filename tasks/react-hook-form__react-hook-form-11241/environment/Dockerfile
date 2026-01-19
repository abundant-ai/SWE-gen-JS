FROM ubuntu:24.04

# Base system packages
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 20.x (package.json requires node >= 18.0.0)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Enable corepack and set up pnpm v8 (package.json engines.pnpm = "8")
RUN corepack enable && corepack prepare pnpm@8 --activate

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/react-hook-form/react-hook-form.git src && \
    cd src && \
    (git fetch --depth 1 origin f3a68d0f841031c2687c5473459585d40d7549c0 || git fetch --depth 1 origin "+refs/pull/11241/head:refs/remotes/origin/pr/11241") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set CI=true to avoid interactive prompts
ENV CI=true

# Install dependencies with frozen lockfile
RUN pnpm install --frozen-lockfile

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

RUN rm -rf /app/src/.git

WORKDIR /app/src