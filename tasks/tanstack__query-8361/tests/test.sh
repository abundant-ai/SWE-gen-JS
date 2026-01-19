#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/query-core/src/__tests__"
cp "/tests/packages/query-core/src/__tests__/queryClient.test-d.tsx" "packages/query-core/src/__tests__/queryClient.test-d.tsx"
mkdir -p "packages/query-core/src/__tests__"
cp "/tests/packages/query-core/src/__tests__/utils.test-d.tsx" "packages/query-core/src/__tests__/utils.test-d.tsx"

# Rebuild after patch was applied (to update type declarations)
pnpm run build:all

# Run TypeScript type checking for query-core package
cd /app/src/packages/query-core
pnpm run test:types:ts57
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
