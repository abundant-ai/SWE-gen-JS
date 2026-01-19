#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "integration/nest-application/global-prefix/e2e"
cp "/tests/integration/nest-application/global-prefix/e2e/global-prefix.spec.ts" "integration/nest-application/global-prefix/e2e/global-prefix.spec.ts"
mkdir -p "packages/core/test/middleware"
cp "/tests/packages/core/test/middleware/utils.spec.ts" "packages/core/test/middleware/utils.spec.ts"

# Configure ts-node to skip type checking (transpile only)
export TS_NODE_TRANSPILE_ONLY=true

# Run the specific test files using mocha with required setup files
npx mocha --require node_modules/reflect-metadata/Reflect.js --require mocha-setup.js --require ts-node/register --require tsconfig-paths/register \
  integration/nest-application/global-prefix/e2e/global-prefix.spec.ts \
  packages/core/test/middleware/utils.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
