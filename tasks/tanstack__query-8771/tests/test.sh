#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/react-query/src/__tests__"
cp "/tests/packages/react-query/src/__tests__/useQuery.test.tsx" "packages/react-query/src/__tests__/useQuery.test.tsx"
mkdir -p "packages/svelte-query-persist-client/tests"
cp "/tests/packages/svelte-query-persist-client/tests/PersistQueryClientProvider.test.ts" "packages/svelte-query-persist-client/tests/PersistQueryClientProvider.test.ts"

# Run tests from each package directory to pick up proper vitest config (jsdom environment)
cd /app/src/packages/react-query
npx vitest run \
  src/__tests__/useQuery.test.tsx \
  --no-coverage
test_status1=$?

cd /app/src/packages/svelte-query-persist-client
npx vitest run \
  tests/PersistQueryClientProvider.test.ts \
  --no-coverage
test_status2=$?

# Fail if any test failed
if [ $test_status1 -ne 0 ] || [ $test_status2 -ne 0 ]; then
  test_status=1
else
  test_status=0
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
