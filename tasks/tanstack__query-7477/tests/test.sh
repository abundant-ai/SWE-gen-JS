#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/svelte-query/src/__tests__"
cp "/tests/packages/svelte-query/src/__tests__/UseMutationState.svelte" "packages/svelte-query/src/__tests__/UseMutationState.svelte"
mkdir -p "packages/svelte-query/src/__tests__"
cp "/tests/packages/svelte-query/src/__tests__/useMutationState.test.ts" "packages/svelte-query/src/__tests__/useMutationState.test.ts"

# Reset NX cache to avoid cache integrity issues after copying files
npx nx reset

# Rebuild svelte-query package after copying test files
cd /app/src/packages/svelte-query
pnpm run build
cd /app/src

# Run the specific test file for useMutationState
cd /app/src/packages/svelte-query
pnpm run test:lib src/__tests__/useMutationState.test.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
