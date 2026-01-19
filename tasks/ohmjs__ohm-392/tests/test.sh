#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/ohm-js/test"
cp "/tests/packages/ohm-js/test/test-typings.ts" "packages/ohm-js/test/test-typings.ts"

# Rebuild to pick up any changes from patches (oracle agent applies fix.patch before running tests)
yarn build

# Run the specific test file from the PR
# ohm-js uses AVA with special TypeScript config for test-typings.ts
cd packages/ohm-js
npx ava --config ava-ts.config.js test/test-typings.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
