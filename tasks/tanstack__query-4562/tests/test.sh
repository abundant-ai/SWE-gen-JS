#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/vue-query/src/__tests__"
cp "/tests/packages/vue-query/src/__tests__/test-utils.ts" "packages/vue-query/src/__tests__/test-utils.ts"
mkdir -p "packages/vue-query/src/__tests__"
cp "/tests/packages/vue-query/src/__tests__/useInfiniteQuery.types.test.tsx" "packages/vue-query/src/__tests__/useInfiniteQuery.types.test.tsx"
mkdir -p "packages/vue-query/src/__tests__"
cp "/tests/packages/vue-query/src/__tests__/useMutation.types.test.tsx" "packages/vue-query/src/__tests__/useMutation.types.test.tsx"
mkdir -p "packages/vue-query/src/__tests__"
cp "/tests/packages/vue-query/src/__tests__/useQuery.types.test.tsx" "packages/vue-query/src/__tests__/useQuery.types.test.tsx"

# Run TypeScript type checking from the root (handles project references correctly)
cd /app/src
npx tsc --build packages/vue-query/tsconfig.json --force --verbose
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
