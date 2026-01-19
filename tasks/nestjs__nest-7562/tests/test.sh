#!/bin/bash

cd /app/src

# Rebuild packages to pick up any code changes (e.g., from oracle's fix.patch)
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "integration/hello-world/e2e"
cp "/tests/integration/hello-world/e2e/exclude-middleware-fastify.spec.ts" "integration/hello-world/e2e/exclude-middleware-fastify.spec.ts"
mkdir -p "integration/hello-world/e2e"
cp "/tests/integration/hello-world/e2e/middleware-class.spec.ts" "integration/hello-world/e2e/middleware-class.spec.ts"
mkdir -p "integration/hello-world/e2e"
cp "/tests/integration/hello-world/e2e/middleware-fastify.spec.ts" "integration/hello-world/e2e/middleware-fastify.spec.ts"
mkdir -p "packages/core/test/middleware"
cp "/tests/packages/core/test/middleware/utils.spec.ts" "packages/core/test/middleware/utils.spec.ts"
mkdir -p "packages/core/test/utils"
cp "/tests/packages/core/test/utils/noop-adapter.spec.ts" "packages/core/test/utils/noop-adapter.spec.ts"

# Configure ts-node to skip type checking (transpile only)
export TS_NODE_TRANSPILE_ONLY=true

# Run the specific test files using mocha with required setup files
npx mocha --require node_modules/reflect-metadata/Reflect.js --require mocha-setup.js --require ts-node/register --require tsconfig-paths/register \
  integration/hello-world/e2e/exclude-middleware-fastify.spec.ts \
  integration/hello-world/e2e/middleware-class.spec.ts \
  integration/hello-world/e2e/middleware-fastify.spec.ts \
  packages/core/test/middleware/utils.spec.ts \
  packages/core/test/utils/noop-adapter.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
