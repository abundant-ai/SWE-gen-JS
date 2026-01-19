#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/query-broadcast-client-experimental/src/__tests__"
cp "/tests/packages/query-broadcast-client-experimental/src/__tests__/index.test.ts" "packages/query-broadcast-client-experimental/src/__tests__/index.test.ts"

# Run specific test files with vitest (disable coverage to avoid threshold issues)
cd packages/query-broadcast-client-experimental
npx vitest run \
  src/__tests__/index.test.ts \
  --no-coverage
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
