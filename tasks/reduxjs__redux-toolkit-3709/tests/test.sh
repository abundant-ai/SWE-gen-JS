#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/toolkit/src/query/tests"
cp "/tests/packages/toolkit/src/query/tests/buildHooks.test.tsx" "packages/toolkit/src/query/tests/buildHooks.test.tsx"
mkdir -p "packages/toolkit/src/query/tests"
cp "/tests/packages/toolkit/src/query/tests/buildInitiate.test.tsx" "packages/toolkit/src/query/tests/buildInitiate.test.tsx"
mkdir -p "packages/toolkit/src/query/tests"
cp "/tests/packages/toolkit/src/query/tests/buildMiddleware.test.tsx" "packages/toolkit/src/query/tests/buildMiddleware.test.tsx"
mkdir -p "packages/toolkit/src/query/tests"
cp "/tests/packages/toolkit/src/query/tests/buildSlice.test.ts" "packages/toolkit/src/query/tests/buildSlice.test.ts"
mkdir -p "packages/toolkit/src/query/tests"
cp "/tests/packages/toolkit/src/query/tests/cacheCollection.test.ts" "packages/toolkit/src/query/tests/cacheCollection.test.ts"
mkdir -p "packages/toolkit/src/query/tests"
cp "/tests/packages/toolkit/src/query/tests/cacheLifecycle.test.ts" "packages/toolkit/src/query/tests/cacheLifecycle.test.ts"
mkdir -p "packages/toolkit/src/query/tests"
cp "/tests/packages/toolkit/src/query/tests/cleanup.test.tsx" "packages/toolkit/src/query/tests/cleanup.test.tsx"
mkdir -p "packages/toolkit/src/query/tests"
cp "/tests/packages/toolkit/src/query/tests/fetchBaseQuery.test.tsx" "packages/toolkit/src/query/tests/fetchBaseQuery.test.tsx"
mkdir -p "packages/toolkit/src/query/tests"
cp "/tests/packages/toolkit/src/query/tests/helpers.tsx" "packages/toolkit/src/query/tests/helpers.tsx"
mkdir -p "packages/toolkit/src/query/tests"
cp "/tests/packages/toolkit/src/query/tests/matchers.test.tsx" "packages/toolkit/src/query/tests/matchers.test.tsx"
mkdir -p "packages/toolkit/src/query/tests"
cp "/tests/packages/toolkit/src/query/tests/polling.test.tsx" "packages/toolkit/src/query/tests/polling.test.tsx"
mkdir -p "packages/toolkit/src/query/tests"
cp "/tests/packages/toolkit/src/query/tests/refetchingBehaviors.test.tsx" "packages/toolkit/src/query/tests/refetchingBehaviors.test.tsx"

# Run specific test files with vitest
cd packages/toolkit

npx vitest run \
  src/query/tests/buildHooks.test.tsx \
  src/query/tests/buildInitiate.test.tsx \
  src/query/tests/buildMiddleware.test.tsx \
  src/query/tests/buildSlice.test.ts \
  src/query/tests/cacheCollection.test.ts \
  src/query/tests/cacheLifecycle.test.ts \
  src/query/tests/cleanup.test.tsx \
  src/query/tests/fetchBaseQuery.test.tsx \
  src/query/tests/helpers.tsx \
  src/query/tests/matchers.test.tsx \
  src/query/tests/polling.test.tsx \
  src/query/tests/refetchingBehaviors.test.tsx \
  --no-coverage
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
