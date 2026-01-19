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

# Enable corepack and set up pnpm (project uses pnpm-lock.yaml)
RUN corepack enable && corepack prepare pnpm@latest --activate

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/react-hook-form/react-hook-form.git src && \
    cd src && \
    (git fetch --depth 1 origin a926460d2011c9f6a332f26cf80fe85f3b771141 || git fetch --depth 1 origin "+refs/pull/12211/head:refs/remotes/origin/pr/12211") && \
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