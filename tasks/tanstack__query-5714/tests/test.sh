#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/query-core/src/tests"
cp "/tests/packages/query-core/src/tests/hydration.test.tsx" "packages/query-core/src/tests/hydration.test.tsx"
mkdir -p "packages/query-core/src/tests"
cp "/tests/packages/query-core/src/tests/onlineManager.test.tsx" "packages/query-core/src/tests/onlineManager.test.tsx"
mkdir -p "packages/query-core/src/tests"
cp "/tests/packages/query-core/src/tests/queryClient.test.tsx" "packages/query-core/src/tests/queryClient.test.tsx"
mkdir -p "packages/query-core/src/tests"
cp "/tests/packages/query-core/src/tests/utils.ts" "packages/query-core/src/tests/utils.ts"
mkdir -p "packages/react-query/src/__tests__"
cp "/tests/packages/react-query/src/__tests__/useMutation.test.tsx" "packages/react-query/src/__tests__/useMutation.test.tsx"
mkdir -p "packages/react-query/src/__tests__"
cp "/tests/packages/react-query/src/__tests__/useQuery.test.tsx" "packages/react-query/src/__tests__/useQuery.test.tsx"
mkdir -p "packages/react-query/src/__tests__"
cp "/tests/packages/react-query/src/__tests__/utils.tsx" "packages/react-query/src/__tests__/utils.tsx"
mkdir -p "packages/solid-query/src/__tests__"
cp "/tests/packages/solid-query/src/__tests__/createMutation.test.tsx" "packages/solid-query/src/__tests__/createMutation.test.tsx"
mkdir -p "packages/solid-query/src/__tests__"
cp "/tests/packages/solid-query/src/__tests__/createQuery.test.tsx" "packages/solid-query/src/__tests__/createQuery.test.tsx"
mkdir -p "packages/solid-query/src/__tests__"
cp "/tests/packages/solid-query/src/__tests__/utils.tsx" "packages/solid-query/src/__tests__/utils.tsx"
mkdir -p "packages/svelte-query/src/__tests__"
cp "/tests/packages/svelte-query/src/__tests__/utils.ts" "packages/svelte-query/src/__tests__/utils.ts"

# Run the specific test files using vitest (the project's test runner)
# Running tests from query-core package
cd /app/src/packages/query-core
pnpm exec vitest run src/tests/hydration.test.tsx src/tests/onlineManager.test.tsx src/tests/queryClient.test.tsx --coverage.enabled=false
test_status=$?

# Only continue if query-core tests passed
if [ $test_status -eq 0 ]; then
  # Running tests from react-query package
  cd /app/src/packages/react-query
  pnpm exec vitest run src/__tests__/useMutation.test.tsx src/__tests__/useQuery.test.tsx --coverage.enabled=false
  test_status=$?
fi

# Only continue if react-query tests passed
if [ $test_status -eq 0 ]; then
  # Running tests from solid-query package
  cd /app/src/packages/solid-query
  pnpm exec vitest run src/__tests__/createMutation.test.tsx src/__tests__/createQuery.test.tsx --coverage.enabled=false
  test_status=$?
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
