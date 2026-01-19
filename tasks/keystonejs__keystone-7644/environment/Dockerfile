FROM ubuntu:24.04

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
    (git fetch --depth 1 origin 1c18ecd8f97bfc57f141e4a26b03074f882444d5 || git fetch --depth 1 origin "+refs/pull/7644/head:refs/remotes/origin/pr/7644") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set environment variables
ENV CI=true
ENV PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1
ENV TEST_ADAPTER=sqlite
ENV DATABASE_URL=file:./dev.db

# Install dependencies
RUN yarn install --frozen-lockfile

# Build the project (preconstruct build)
RUN yarn build

# Install Playwright browsers (required for admin-ui tests)
RUN npx playwright install --with-deps chromium

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Reinstall dependencies after bug.patch (package.json and yarn.lock were modified)
RUN yarn install --frozen-lockfile

# Rebuild after applying bug.patch (TypeScript needs recompilation)
RUN yarn build

RUN rm -rf /app/src/.git

WORKDIR /app/src