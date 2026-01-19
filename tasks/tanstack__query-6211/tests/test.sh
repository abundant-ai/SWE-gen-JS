#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/svelte-query/src/__tests__"
cp "/tests/packages/svelte-query/src/__tests__/CreateQuery.svelte" "packages/svelte-query/src/__tests__/CreateQuery.svelte"

# This is a TypeScript type-level bug - run type checking on the svelte-query package
# The bug causes type errors when StoreOrVal wrapper is missing from function signatures
cd /app/src/packages/svelte-query
pnpm run test:types
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
