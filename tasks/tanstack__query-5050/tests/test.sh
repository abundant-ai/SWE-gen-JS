#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/svelte-query/src/__tests__"
cp "/tests/packages/svelte-query/src/__tests__/CreateQueries.svelte" "packages/svelte-query/src/__tests__/CreateQueries.svelte"
mkdir -p "packages/svelte-query/src/__tests__"
cp "/tests/packages/svelte-query/src/__tests__/CreateQuery.svelte" "packages/svelte-query/src/__tests__/CreateQuery.svelte"
mkdir -p "packages/svelte-query/src/__tests__"
cp "/tests/packages/svelte-query/src/__tests__/createQuery.test.ts" "packages/svelte-query/src/__tests__/createQuery.test.ts"

# Build query-core (required dependency)
cd /app/src/packages/query-core
pnpm run build >/dev/null 2>&1

# Run the specific test file with vitest (disable coverage)
cd /app/src/packages/svelte-query
NODE_OPTIONS="--max-old-space-size=2048" npx vitest run src/__tests__/createQuery.test.ts --coverage.enabled=false --threads=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
