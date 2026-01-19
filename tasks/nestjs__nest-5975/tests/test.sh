#!/bin/bash

cd /app/src

# Rebuild packages to pick up any code changes (e.g., from oracle's fix.patch)
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/websockets/test/factories"
cp "/tests/packages/websockets/test/factories/ws-params-factory.spec.ts" "packages/websockets/test/factories/ws-params-factory.spec.ts"

# Configure ts-node to skip type checking (transpile only)
export TS_NODE_TRANSPILE_ONLY=true

# Run the specific test file using mocha with required setup files
npx mocha --require node_modules/reflect-metadata/Reflect.js --require mocha-setup.js --require ts-node/register --require tsconfig-paths/register \
  packages/websockets/test/factories/ws-params-factory.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
