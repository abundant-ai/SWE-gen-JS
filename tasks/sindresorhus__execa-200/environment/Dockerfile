FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 20
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/sindresorhus/execa.git src && \
    cd src && \
    (git fetch --depth 1 origin 5c15cf2f759117a4881fb78a809d90f5a9174031 || git fetch --depth 1 origin "+refs/pull/200/head:refs/remotes/origin/pr/200") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set CI environment variable
ENV CI=true

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
# Note: Using git apply instead of patch because bug.patch contains file renames with spaces
COPY bug.patch /tmp/bug.patch
RUN git apply /tmp/bug.patch && rm /tmp/bug.patch

# Install dependencies (after bug.patch to get correct dependency versions)
RUN npm install

RUN rm -rf /app/src/.git

WORKDIR /app/src