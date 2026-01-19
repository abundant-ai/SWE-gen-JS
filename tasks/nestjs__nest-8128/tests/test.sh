#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "integration/versioning/e2e"
cp "/tests/integration/versioning/e2e/header-versioning-fastify.spec.ts" "integration/versioning/e2e/header-versioning-fastify.spec.ts"
mkdir -p "integration/versioning/e2e"
cp "/tests/integration/versioning/e2e/header-versioning.spec.ts" "integration/versioning/e2e/header-versioning.spec.ts"
mkdir -p "integration/versioning/e2e"
cp "/tests/integration/versioning/e2e/media-type-versioning-fastify.spec.ts" "integration/versioning/e2e/media-type-versioning-fastify.spec.ts"
mkdir -p "integration/versioning/e2e"
cp "/tests/integration/versioning/e2e/media-type-versioning.spec.ts" "integration/versioning/e2e/media-type-versioning.spec.ts"
mkdir -p "integration/versioning/e2e"
cp "/tests/integration/versioning/e2e/uri-versioning-fastify.spec.ts" "integration/versioning/e2e/uri-versioning-fastify.spec.ts"
mkdir -p "integration/versioning/e2e"
cp "/tests/integration/versioning/e2e/uri-versioning.spec.ts" "integration/versioning/e2e/uri-versioning.spec.ts"

# Configure ts-node to skip type checking (transpile only)
export TS_NODE_TRANSPILE_ONLY=true

# Run the specific test files using mocha with required setup files
npx mocha --require node_modules/reflect-metadata/Reflect.js --require mocha-setup.js --require ts-node/register --require tsconfig-paths/register \
  integration/versioning/e2e/header-versioning-fastify.spec.ts \
  integration/versioning/e2e/header-versioning.spec.ts \
  integration/versioning/e2e/media-type-versioning-fastify.spec.ts \
  integration/versioning/e2e/media-type-versioning.spec.ts \
  integration/versioning/e2e/uri-versioning-fastify.spec.ts \
  integration/versioning/e2e/uri-versioning.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
