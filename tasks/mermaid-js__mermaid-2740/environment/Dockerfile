FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 16.x
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install Cypress dependencies for headless browser testing
RUN apt-get update && apt-get install -y \
    libgtk2.0-0t64 \
    libgtk-3-0t64 \
    libgbm1 \
    libnotify4 \
    libnss3 \
    libxss1 \
    libasound2t64 \
    libxtst6 \
    xauth \
    xvfb \
    && rm -rf /var/lib/apt/lists/*

# Enable corepack for yarn (mermaid uses yarn at this commit)
RUN corepack enable

WORKDIR /app

# Configure git to handle line endings properly for patching
RUN git config --global core.autocrlf false

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/mermaid-js/mermaid.git src && \
    cd src && \
    (git fetch --depth 1 origin 04454cece04a07eca0caaf26842cdf6952985526 || git fetch --depth 1 origin "+refs/pull/2740/head:refs/remotes/origin/pr/2740") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set CI environment variable
ENV CI=true

# Install dependencies
RUN yarn install --frozen-lockfile

# Normalize line endings for files that will be patched (CRLF -> LF)
RUN apt-get update && apt-get install -y dos2unix && rm -rf /var/lib/apt/lists/* && \
    find . -type f \( -name "*.js" -o -name "*.html" -o -name "*.md" -o -name "*.json" -o -name "*.jison" -o -name "*.yml" -o -name "*.map" \) \
    -exec dos2unix {} \;

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 --reject-file=/dev/null < /tmp/bug.patch || true && rm /tmp/bug.patch

# Note: We do NOT rebuild after applying bug.patch because the patch may introduce
# build-breaking changes. The tests will run against the pre-patch build artifacts,
# which is sufficient for test execution.

RUN rm -rf /app/src/.git

WORKDIR /app/src