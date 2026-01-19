#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/eslint-plugin-query/src/__tests__"
cp "/tests/packages/eslint-plugin-query/src/__tests__/no-void-query-fn.test.ts" "packages/eslint-plugin-query/src/__tests__/no-void-query-fn.test.ts"
mkdir -p "packages/eslint-plugin-query/src/__tests__/ts-fixture"
cp "/tests/packages/eslint-plugin-query/src/__tests__/ts-fixture/file.ts" "packages/eslint-plugin-query/src/__tests__/ts-fixture/file.ts"
mkdir -p "packages/eslint-plugin-query/src/__tests__/ts-fixture"
cp "/tests/packages/eslint-plugin-query/src/__tests__/ts-fixture/tsconfig.json" "packages/eslint-plugin-query/src/__tests__/ts-fixture/tsconfig.json"

# Run specific test files with vitest (disable coverage to avoid threshold issues)
cd packages/eslint-plugin-query
npx vitest run \
  src/__tests__/no-void-query-fn.test.ts \
  --no-coverage
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
