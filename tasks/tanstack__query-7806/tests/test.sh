#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
# Note: bug.patch renamed infiniteQueryOptions.test-d.tsx to createInfiniteQuery.test-d.tsx
# We need to remove the renamed file and restore the original name with HEAD content
rm -f "packages/solid-query/src/__tests__/createInfiniteQuery.test-d.tsx"
mkdir -p "packages/solid-query/src/__tests__"
cp "/tests/packages/solid-query/src/__tests__/infiniteQueryOptions.test-d.tsx" "packages/solid-query/src/__tests__/infiniteQueryOptions.test-d.tsx"
cp "/tests/packages/solid-query/src/__tests__/queryOptions.test-d.tsx" "packages/solid-query/src/__tests__/queryOptions.test-d.tsx"

# Reset NX cache to avoid cache integrity issues after copying files
npx nx reset

# Rebuild after copying test files (to update compiled output)
pnpm run build:all

# Run the specific test files for this PR
cd /app/src/packages/solid-query
pnpm run test:lib src/__tests__/infiniteQueryOptions.test-d.tsx src/__tests__/queryOptions.test-d.tsx --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
