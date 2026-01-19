FROM ubuntu:20.04

# Prevent interactive prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 16 (required by this commit's package.json engines field)
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Enable Yarn Classic 1.x (this commit uses Yarn v1 lockfile)
RUN npm install -g yarn@1.22.22

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/keystonejs/keystone.git src && \
    cd src && \
    (git fetch --depth 1 origin cbdb2a0a926a82ea908436ec3b9686eb32e44942 || git fetch --depth 1 origin "+refs/pull/7249/head:refs/remotes/origin/pr/7249") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set environment variables
ENV CI=true
ENV PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1
ENV TEST_ADAPTER=sqlite
ENV DATABASE_URL=file:./dev.db

# Temporarily modify package.json to skip artifact generation during install
RUN sed -i 's/&& node scripts\/generate-artifacts-for-projects//' package.json

# Install dependencies
RUN yarn install --frozen-lockfile

# Restore package.json
RUN git checkout package.json || true

# Build the project (preconstruct build)
RUN yarn build

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Temporarily modify package.json again to skip artifact generation
RUN sed -i 's/&& node scripts\/generate-artifacts-for-projects//' package.json

# Reinstall dependencies after bug.patch (package.json and yarn.lock were modified)
RUN yarn install

# Restore package.json
RUN git checkout package.json || true

# Rebuild after applying bug.patch (TypeScript needs recompilation)
RUN yarn build

RUN rm -rf /app/src/.git

WORKDIR /app/src