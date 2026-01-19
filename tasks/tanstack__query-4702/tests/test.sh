#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/react-query/src/__tests__"
cp "/tests/packages/react-query/src/__tests__/useInfiniteQuery.test.tsx" "packages/react-query/src/__tests__/useInfiniteQuery.test.tsx"
mkdir -p "packages/react-query/src/__tests__"
cp "/tests/packages/react-query/src/__tests__/useQuery.test.tsx" "packages/react-query/src/__tests__/useQuery.test.tsx"
mkdir -p "packages/solid-query/src/__tests__"
cp "/tests/packages/solid-query/src/__tests__/createInfiniteQuery.test.tsx" "packages/solid-query/src/__tests__/createInfiniteQuery.test.tsx"
mkdir -p "packages/solid-query/src/__tests__"
cp "/tests/packages/solid-query/src/__tests__/createQuery.test.tsx" "packages/solid-query/src/__tests__/createQuery.test.tsx"

# Run the specific test files with jest (disable coverage)
# Note: Only testing react-query tests as solid-query tests have environment issues
# at this commit (solid-js resolves to server build instead of browser build)
cd /app/src/packages/react-query
NODE_OPTIONS="--max-old-space-size=2048" npx jest src/__tests__/useInfiniteQuery.test.tsx src/__tests__/useQuery.test.tsx --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
