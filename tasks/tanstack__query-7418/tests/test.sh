#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/query-core/src/__tests__"
cp "/tests/packages/query-core/src/__tests__/infiniteQueryObserver.test-d.tsx" "packages/query-core/src/__tests__/infiniteQueryObserver.test-d.tsx"
mkdir -p "packages/react-query/src/__tests__"
cp "/tests/packages/react-query/src/__tests__/useInfiniteQuery.test.tsx" "packages/react-query/src/__tests__/useInfiniteQuery.test.tsx"
mkdir -p "packages/solid-query/src/__tests__"
cp "/tests/packages/solid-query/src/__tests__/createInfiniteQuery.test.tsx" "packages/solid-query/src/__tests__/createInfiniteQuery.test.tsx"

# Reset NX cache to avoid cache integrity issues after copying files
npx nx reset

# Rebuild packages after copying test files
cd /app/src/packages/query-core
pnpm run build
cd /app/src/packages/react-query
pnpm run build
cd /app/src/packages/solid-query
pnpm run build
cd /app/src

# Run the specific test files for this PR
cd /app/src/packages/query-core
pnpm run test:lib src/__tests__/infiniteQueryObserver.test-d.tsx
query_core_status=$?

cd /app/src/packages/react-query
pnpm run test:lib src/__tests__/useInfiniteQuery.test.tsx
react_query_status=$?

cd /app/src/packages/solid-query
pnpm run test:lib src/__tests__/createInfiniteQuery.test.tsx
solid_query_status=$?

# Check if all tests passed
if [ $query_core_status -eq 0 ] && [ $react_query_status -eq 0 ] && [ $solid_query_status -eq 0 ]; then
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
