#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/angular-query-experimental/src/__tests__"
cp "/tests/packages/angular-query-experimental/src/__tests__/inject-mutation-state.test-d.ts" "packages/angular-query-experimental/src/__tests__/inject-mutation-state.test-d.ts"
mkdir -p "packages/angular-query-experimental/src/__tests__"
cp "/tests/packages/angular-query-experimental/src/__tests__/inject-mutation-state.test.ts" "packages/angular-query-experimental/src/__tests__/inject-mutation-state.test.ts"
mkdir -p "packages/angular-query-experimental/src/__tests__"
cp "/tests/packages/angular-query-experimental/src/__tests__/inject-mutation.test.ts" "packages/angular-query-experimental/src/__tests__/inject-mutation.test.ts"

# Reset NX cache to avoid cache integrity issues after copying files
npx nx reset

# Rebuild packages after copying test files
cd /app/src/packages/query-core
pnpm run build
cd /app/src/packages/angular-query-experimental
pnpm run build
cd /app/src

# Run the specific test files for this PR
cd /app/src/packages/angular-query-experimental
pnpm run test:lib src/__tests__/inject-mutation-state.test-d.ts src/__tests__/inject-mutation-state.test.ts src/__tests__/inject-mutation.test.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
  exit 0
else
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi
