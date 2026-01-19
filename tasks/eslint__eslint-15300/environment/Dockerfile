FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 20.x (ESLint requires ^18.18.0 || ^20.9.0 || >=21.1.0)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/eslint/eslint.git src && \
    cd src && \
    (git fetch --depth 1 origin 75a41ff095585d5de2848319000456eb6689817a || git fetch --depth 1 origin "+refs/pull/15300/head:refs/remotes/origin/pr/15300") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Install dependencies (--legacy-peer-deps needed for eslint@9.0.0-alpha.2 peer dependency conflicts)
RUN npm install --legacy-peer-deps

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Reinstall dependencies after patch (force espree to exact version 9.1.0, not 9.2.0+)
# The ^9.1.0 semver would still match 9.2.0+, so we need to explicitly install 9.1.0
# Use --no-save to avoid modifying package.json (so fix.patch can still apply)
RUN rm -rf node_modules package-lock.json && \
    npm install --legacy-peer-deps && \
    npm install espree@9.1.0 --legacy-peer-deps --no-save

RUN rm -rf /app/src/.git

WORKDIR /app/src