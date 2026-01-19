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

# Enable corepack for yarn (mermaid uses yarn at this commit)
RUN corepack enable

WORKDIR /app

# Configure git to handle line endings properly for patching
RUN git config --global core.autocrlf false

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/mermaid-js/mermaid.git src && \
    cd src && \
    (git fetch --depth 1 origin 19a9f90186624935f9a0f294dde992fc1edd3555 || git fetch --depth 1 origin "+refs/pull/3335/head:refs/remotes/origin/pr/3335") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set CI environment variable
ENV CI=true

# Install dependencies
RUN yarn install --frozen-lockfile

# Normalize line endings for files that will be patched (CRLF -> LF)
RUN apt-get update && apt-get install -y dos2unix && rm -rf /var/lib/apt/lists/* && \
    find cypress/integration/rendering demos docs package.json src/dagre-wrapper src/diagrams/class src/diagrams/git src/diagrams/common src/diagrams/er \
    -type f \( -name "*.js" -o -name "*.html" -o -name "*.md" -o -name "*.json" -o -name "*.jison" \) \
    -exec dos2unix {} \;

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Note: We do NOT rebuild after applying bug.patch because the patch may introduce
# build-breaking changes. The tests will run against the pre-patch build artifacts,
# which is sufficient for test execution.

RUN rm -rf /app/src/.git

WORKDIR /app/src