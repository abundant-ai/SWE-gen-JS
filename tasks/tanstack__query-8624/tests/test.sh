#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/react-query/src/__tests__"
cp "/tests/packages/react-query/src/__tests__/useQueries.test-d.tsx" "packages/react-query/src/__tests__/useQueries.test-d.tsx"
mkdir -p "packages/react-query/src/__tests__"
cp "/tests/packages/react-query/src/__tests__/useSuspenseQueries.test-d.tsx" "packages/react-query/src/__tests__/useSuspenseQueries.test-d.tsx"
mkdir -p "packages/solid-query/src/__tests__"
cp "/tests/packages/solid-query/src/__tests__/createQueries.test-d.tsx" "packages/solid-query/src/__tests__/createQueries.test-d.tsx"
mkdir -p "packages/svelte-query/tests/createQueries"
cp "/tests/packages/svelte-query/tests/createQueries/createQueries.test-d.ts" "packages/svelte-query/tests/createQueries/createQueries.test-d.ts"
mkdir -p "packages/vue-query/src/__tests__"
cp "/tests/packages/vue-query/src/__tests__/useQueries.test-d.ts" "packages/vue-query/src/__tests__/useQueries.test-d.ts"

# Run vitest from vue-query package (cleanest package without unrelated errors)
cd /app/src/packages/vue-query
npx vitest run \
  src/__tests__/useQueries.test-d.ts \
  --no-coverage
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
