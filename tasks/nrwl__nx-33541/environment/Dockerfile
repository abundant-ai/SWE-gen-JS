FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js (project uses Node.js/TypeScript)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install additional packages required by CI and dependencies
RUN apt-get update && apt-get install -y \
    python3 \
    lsof \
    libvips-dev \
    libglib2.0-dev \
    libgirepository1.0-dev \
    && rm -rf /var/lib/apt/lists/*

# Enable corepack for pnpm (package manager used by this project)
RUN corepack enable && corepack prepare pnpm@10.11.1 --activate

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/nrwl/nx.git src && \
    cd src && \
    (git fetch --depth 1 origin d1d5bcbb8a4b9f697ea149c26b55d8c0b332917e || git fetch --depth 1 origin "+refs/pull/33541/head:refs/remotes/origin/pr/33541") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set CI environment variable
ENV CI=true

# Install dependencies with pnpm
RUN pnpm install --frozen-lockfile

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

RUN rm -rf /app/src/.git

WORKDIR /app/src