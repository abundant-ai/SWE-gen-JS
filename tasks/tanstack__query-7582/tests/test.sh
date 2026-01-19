#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/react-query/src/__tests__"
cp "/tests/packages/react-query/src/__tests__/prefetch.test-d.tsx" "packages/react-query/src/__tests__/prefetch.test-d.tsx"
mkdir -p "packages/react-query/src/__tests__"
cp "/tests/packages/react-query/src/__tests__/prefetch.test.tsx" "packages/react-query/src/__tests__/prefetch.test.tsx"

# Reset NX cache to avoid cache integrity issues after copying files
npx nx reset

# Rebuild react-query package after copying test files
cd /app/src/packages/react-query
pnpm run build
cd /app/src

# Run type-checking tests for prefetch.test-d.tsx
cd /app/src/packages/react-query
pnpm run test:types
type_test_status=$?

# Run regular tests for prefetch.test.tsx using vitest
pnpm run test:lib src/__tests__/prefetch.test.tsx
regular_test_status=$?

# Combine test results
if [ $type_test_status -eq 0 ] && [ $regular_test_status -eq 0 ]; then
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
