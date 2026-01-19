#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/query-core/src/__tests__"
cp "/tests/packages/query-core/src/__tests__/queryClient.test-d.tsx" "packages/query-core/src/__tests__/queryClient.test-d.tsx"

# Run tests from the package directory to pick up proper vitest config
cd /app/src/packages/query-core
npx vitest run \
  src/__tests__/queryClient.test-d.tsx \
  --no-coverage
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
