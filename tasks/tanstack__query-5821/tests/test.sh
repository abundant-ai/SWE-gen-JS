#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/eslint-plugin-query/src/__tests__"
cp "/tests/packages/eslint-plugin-query/src/__tests__/configs.test.ts" "packages/eslint-plugin-query/src/__tests__/configs.test.ts"
mkdir -p "packages/eslint-plugin-query/src/__tests__"
cp "/tests/packages/eslint-plugin-query/src/__tests__/exhaustive-deps.test.ts" "packages/eslint-plugin-query/src/__tests__/exhaustive-deps.test.ts"

# Run the specific test files using vitest
cd /app/src/packages/eslint-plugin-query
pnpm run test:lib -- src/__tests__/configs.test.ts src/__tests__/exhaustive-deps.test.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
