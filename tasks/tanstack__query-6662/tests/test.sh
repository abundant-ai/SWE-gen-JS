#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/angular-query-experimental/src/__tests__"
cp "/tests/packages/angular-query-experimental/src/__tests__/inject-mutation.test-d.ts" "packages/angular-query-experimental/src/__tests__/inject-mutation.test-d.ts"
mkdir -p "packages/angular-query-experimental/src/__tests__"
cp "/tests/packages/angular-query-experimental/src/__tests__/inject-query.test-d.ts" "packages/angular-query-experimental/src/__tests__/inject-query.test-d.ts"

# Reset NX cache to avoid cache integrity issues after copying files
npx nx reset

# Rebuild package after copying test files
cd /app/src/packages/angular-query-experimental
pnpm run build
cd /app/src

# Run the specific test files for this PR using vitest typecheck
cd /app/src/packages/angular-query-experimental
pnpm run test:lib --typecheck --run src/__tests__/inject-mutation.test-d.ts src/__tests__/inject-query.test-d.ts --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
