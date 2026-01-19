FROM ubuntu:24.04

# Base system packages (common to all languages)
RUN apt-get update && apt-get install -y \
    git \
    curl \
    ca-certificates \
    patch \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 20.x
RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs && \
    rm -rf /var/lib/apt/lists/*

# Install pnpm v8 (compatible with lockfileVersion 6.1)
RUN npm install -g pnpm@8

WORKDIR /app

# Clone repo at HEAD commit (with fix applied)
RUN git clone https://github.com/ohmjs/ohm.git src && \
    cd src && \
    (git fetch --depth 1 origin 3960b3dd8044bd2cba9a17a1715274d88e3cba57 || git fetch --depth 1 origin "+refs/pull/477/head:refs/remotes/origin/pr/477") && \
    git checkout --detach FETCH_HEAD && \
    git submodule update --init --recursive

WORKDIR /app/src

# Install dependencies with pnpm
RUN pnpm install --frozen-lockfile

# Build the project (generates grammar files from spec/overrides)
RUN pnpm build

# If install/build steps touched tracked files (lockfiles, generated assets),
# reset them so bug.patch applies cleanly.
RUN git reset --hard

# Apply bug.patch to revert to buggy state (BASE)
COPY bug.patch /tmp/bug.patch
RUN patch -p1 < /tmp/bug.patch && rm /tmp/bug.patch

# Rebuild after patching (the bug.patch modifies override JSON files that affect grammar generation)
# The es-grammars package doesn't have a build script, so we need to manually regenerate the affected grammars
WORKDIR /app/src/packages/es-grammars
RUN node scripts/generate-ecmascript-grammar.mjs ES2017 spec/es2017/spec.grammar spec/es2017/overrides.json > gen/es2017.grammar.ohm && \
    node scripts/generate-ecmascript-grammar.mjs ES2018 spec/es2018/spec.grammar spec/es2018/overrides.json > gen/es2018.grammar.ohm && \
    node scripts/generate-ecmascript-grammar.mjs ES2019 spec/es2019/spec.grammar spec/es2019/overrides.json > gen/es2019.grammar.ohm && \
    node scripts/generate-ecmascript-grammar.mjs ES2020 spec/es2020/spec.grammar spec/es2020/overrides.json > gen/es2020.grammar.ohm && \
    node scripts/generate-ecmascript-grammar.mjs ES2021 spec/es2021/spec.grammar spec/es2021/overrides.json > gen/es2021.grammar.ohm && \
    node scripts/generate-ecmascript-grammar.mjs ES2022 spec/es2022/spec.grammar spec/es2022/overrides.json > gen/es2022.grammar.ohm
WORKDIR /app/src

RUN rm -rf /app/src/.git

WORKDIR /app/src