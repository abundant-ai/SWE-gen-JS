#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "integration/testing-module-override/e2e"
cp "/tests/integration/testing-module-override/e2e/modules-override.spec.ts" "integration/testing-module-override/e2e/modules-override.spec.ts"
mkdir -p "packages/core/test/injector"
cp "/tests/packages/core/test/injector/container.spec.ts" "packages/core/test/injector/container.spec.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/scanner.spec.ts" "packages/core/test/scanner.spec.ts"

# Configure ts-node to skip type checking (transpile only)
export TS_NODE_TRANSPILE_ONLY=true

# Run the specific test files using mocha with required setup files
npx mocha --require node_modules/reflect-metadata/Reflect.js --require mocha-setup.js --require ts-node/register --require tsconfig-paths/register \
  integration/testing-module-override/e2e/modules-override.spec.ts \
  packages/core/test/injector/container.spec.ts \
  packages/core/test/scanner.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
