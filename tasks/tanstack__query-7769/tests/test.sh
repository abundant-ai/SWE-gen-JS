#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/react-query/src/__tests__"
cp "/tests/packages/react-query/src/__tests__/queryOptions.test-d.tsx" "packages/react-query/src/__tests__/queryOptions.test-d.tsx"
mkdir -p "packages/svelte-query/tests/createQueries"
cp "/tests/packages/svelte-query/tests/createQueries/createQueries.test-d.ts" "packages/svelte-query/tests/createQueries/createQueries.test-d.ts"
mkdir -p "packages/svelte-query/tests/createQuery"
cp "/tests/packages/svelte-query/tests/createQuery/createQuery.test-d.ts" "packages/svelte-query/tests/createQuery/createQuery.test-d.ts"
mkdir -p "packages/svelte-query/tests/infiniteQueryOptions"
cp "/tests/packages/svelte-query/tests/infiniteQueryOptions/infiniteQueryOptions.test-d.ts" "packages/svelte-query/tests/infiniteQueryOptions/infiniteQueryOptions.test-d.ts"
mkdir -p "packages/svelte-query/tests/queryOptions"
cp "/tests/packages/svelte-query/tests/queryOptions/queryOptions.test-d.ts" "packages/svelte-query/tests/queryOptions/queryOptions.test-d.ts"

# Reset NX cache to avoid cache integrity issues after copying files
npx nx reset

# Rebuild after copying test files (to update compiled output)
pnpm run build:all

# Run type-checking tests for the specific test files
# These are .test-d.tsx/.test-d.ts files that check TypeScript types

# Run react-query type tests
cd /app/src/packages/react-query
pnpm run test:types
react_query_status=$?

# Run svelte-query type tests
cd /app/src/packages/svelte-query
pnpm run test:types
svelte_query_status=$?

# Combine test results
if [ $react_query_status -eq 0 ] && [ $svelte_query_status -eq 0 ]; then
  test_status=0
else
  test_status=1
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
