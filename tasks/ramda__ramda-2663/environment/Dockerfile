FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 20 LTS
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/ramda/ramda.git src && \
    cd src && \
    (git fetch --depth 1 origin b0fccdc79c1d039047f4e452f7f49ee9eacfa137 || git fetch --depth 1 origin "+refs/pull/2663/head:refs/remotes/origin/pr/2663") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Install dependencies with npm install (package-lock.json is out of sync)
RUN npm install

# Build the project with Babel (transpile source/ to src/ and es/)
RUN npm run build

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Clean and rebuild after applying bug.patch
RUN npm run clean && npm run build

RUN rm -rf /app/src/.git

WORKDIR /app/src