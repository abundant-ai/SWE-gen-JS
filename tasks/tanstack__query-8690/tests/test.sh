#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/angular-query-experimental/src/__tests__"
cp "/tests/packages/angular-query-experimental/src/__tests__/inject-queries.test-d.ts" "packages/angular-query-experimental/src/__tests__/inject-queries.test-d.ts"
cp "/tests/packages/angular-query-experimental/src/__tests__/inject-queries.test.ts" "packages/angular-query-experimental/src/__tests__/inject-queries.test.ts"

# Run tests from the package directory to pick up proper vitest config
cd /app/src/packages/angular-query-experimental
npx vitest run \
  src/__tests__/inject-queries.test-d.ts \
  src/__tests__/inject-queries.test.ts \
  --no-coverage
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
