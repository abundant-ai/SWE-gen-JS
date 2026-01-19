FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Additional base system packages
RUN apt-get update && apt-get install -y \
    python3-minimal \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 20.x (using LTS version to avoid Node 22's experimental TS support issues)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install Redis server (needed for tests)
RUN apt-get update && apt-get install -y redis-server && \
    rm -rf /var/lib/apt/lists/*

# Install Python 3.10 specifically (CI uses 3.10, tests expect 3.10 error message format)
RUN apt-get update && apt-get install -y software-properties-common && \
    add-apt-repository -y ppa:deadsnakes/ppa && \
    apt-get update && apt-get install -y \
    python3.10 \
    python3.10-venv \
    python3.10-dev \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Make python3.10 the default python3
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.10 1

# Install uv for faster Python package management
RUN curl -LsSf https://astral.sh/uv/install.sh | sh && mv /root/.local/bin/uv /usr/local/bin/uv

# Enable Yarn via corepack
RUN corepack enable

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/taskforcesh/bullmq.git src && \
    cd src && \
    (git fetch --depth 1 origin 0e1ad44d7aecf67f401ea73c0b16b02f9da96fe7 || git fetch --depth 1 origin "+refs/pull/2904/head:refs/remotes/origin/pr/2904") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

ENV CI=true
ENV NODE_ENV=test

# Install TypeScript/Node.js dependencies
RUN yarn install --frozen-lockfile

# Fix mocha.setup.ts for CJS/ESM compatibility
RUN sed -i "s/chai\.use(chaiAsPromised);/chai.use(chaiAsPromised.default || chaiAsPromised);/" mocha.setup.ts

# Build TypeScript
RUN yarn build

# Copy Lua scripts to Python module
RUN yarn run copy:lua:python

# Install Python dependencies using uv
RUN cd python && \
    uv venv /opt/venv && \
    uv pip install --python /opt/venv/bin/python -e . && \
    uv pip install --python /opt/venv/bin/python pytest pytest-timeout

ENV PATH="/opt/venv/bin:${PATH}"

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Rebuild TypeScript after patching
RUN yarn build

RUN rm -rf /app/src/.git

WORKDIR /app/src