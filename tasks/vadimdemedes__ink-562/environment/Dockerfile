FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 20 (required by package.json engines.node >= 20)
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/vadimdemedes/ink.git src && \
    cd src && \
    (git fetch --depth 1 origin 4b56d04297058f7d7dafb6fbb1b111e69fabac97 || git fetch --depth 1 origin "+refs/pull/562/head:refs/remotes/origin/pr/562") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Set environment variables (from CI config)
ENV FORCE_COLOR=true
ENV CI=false

# Install dependencies (skip prepare script to avoid build errors in fixed state)
RUN npm install --ignore-scripts

# Rebuild native modules (node-pty) since we skipped install scripts
RUN npm rebuild node-pty

# Temporarily add @ts-nocheck to top of file to allow build at HEAD commit (bypasses unused @ts-expect-error error)
RUN sed -i '1i// @ts-nocheck' src/ink.tsx

# Build TypeScript project (required before tests can run)
RUN npm run build

# Remove the @ts-nocheck we added
RUN sed -i '1d' src/ink.tsx

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Backup tsconfig.json before modifying it
RUN cp tsconfig.json tsconfig.json.bak

# Temporarily allow TypeScript to emit JS despite errors
RUN node -e "const fs=require('fs'); const cfg=JSON.parse(fs.readFileSync('tsconfig.json')); cfg.compilerOptions.noEmitOnError=false; fs.writeFileSync('tsconfig.json', JSON.stringify(cfg, null, '\t'));"

# Build with the buggy state (will have errors but produce output)
RUN npm run build || true

# Restore original tsconfig.json so fix.patch can apply cleanly
RUN mv tsconfig.json.bak tsconfig.json

RUN rm -rf /app/src/.git

WORKDIR /app/src