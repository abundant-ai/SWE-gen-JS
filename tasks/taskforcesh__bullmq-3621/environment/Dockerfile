FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    python3-minimal \
    make \
    g++ \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 22.x (required by package.json engines)
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install Python 3.10 and uv (for Python tests)
RUN apt-get update && apt-get install -y \
    python3 python3-pip python3-venv python3-dev \
    && rm -rf /var/lib/apt/lists/*

RUN curl -LsSf https://astral.sh/uv/install.sh | sh && \
    mv /root/.local/bin/uv /usr/local/bin/uv

# Install Redis server (needed for tests)
RUN apt-get update && apt-get install -y redis-server && \
    rm -rf /var/lib/apt/lists/*

# Enable Yarn via corepack
RUN corepack enable

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/taskforcesh/bullmq.git src && \
    cd src && \
    (git fetch --depth 1 origin 503189c599ebeb1aa531e8617210d8677c0f14af || git fetch --depth 1 origin "+refs/pull/3621/head:refs/remotes/origin/pr/3621") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

ENV CI=true
ENV NODE_ENV=test

# Install TypeScript/Node.js dependencies and build
RUN yarn install --frozen-lockfile
RUN yarn build

# Install Python dependencies and copy Lua scripts
WORKDIR /app/src/python
RUN uv venv /opt/venv && \
    uv pip install --python /opt/venv/bin/python -r requirements.txt
ENV PATH="/opt/venv/bin:${PATH}"

# Copy Lua scripts to Python package (needed for tests)
RUN bash copy_scripts.sh

WORKDIR /app/src

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