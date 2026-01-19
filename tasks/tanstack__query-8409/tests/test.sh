#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/angular-query-experimental/src/__tests__"
cp "/tests/packages/angular-query-experimental/src/__tests__/inject-mutation-state.test.ts" "packages/angular-query-experimental/src/__tests__/inject-mutation-state.test.ts"
mkdir -p "packages/angular-query-experimental/src/__tests__"
cp "/tests/packages/angular-query-experimental/src/__tests__/inject-mutation.test.ts" "packages/angular-query-experimental/src/__tests__/inject-mutation.test.ts"
mkdir -p "packages/angular-query-experimental/src/__tests__"
cp "/tests/packages/angular-query-experimental/src/__tests__/inject-query.test.ts" "packages/angular-query-experimental/src/__tests__/inject-query.test.ts"

# Run vitest from angular-query-experimental package directory
cd /app/src/packages/angular-query-experimental
npx vitest run src/__tests__/inject-mutation-state.test.ts src/__tests__/inject-mutation.test.ts src/__tests__/inject-query.test.ts --no-coverage
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
