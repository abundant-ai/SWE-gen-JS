#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/svelte-query-persist-client/tests/FreshData"
cp "/tests/packages/svelte-query-persist-client/tests/FreshData/FreshData.svelte" "packages/svelte-query-persist-client/tests/FreshData/FreshData.svelte"
mkdir -p "packages/svelte-query/tests/createInfiniteQuery"
cp "/tests/packages/svelte-query/tests/createInfiniteQuery/BaseExample.svelte" "packages/svelte-query/tests/createInfiniteQuery/BaseExample.svelte"
mkdir -p "packages/svelte-query/tests/createInfiniteQuery"
cp "/tests/packages/svelte-query/tests/createInfiniteQuery/SelectExample.svelte" "packages/svelte-query/tests/createInfiniteQuery/SelectExample.svelte"
mkdir -p "packages/svelte-query/tests/createMutation"
cp "/tests/packages/svelte-query/tests/createMutation/FailureExample.svelte" "packages/svelte-query/tests/createMutation/FailureExample.svelte"
mkdir -p "packages/svelte-query/tests/createMutation"
cp "/tests/packages/svelte-query/tests/createMutation/OnSuccessExample.svelte" "packages/svelte-query/tests/createMutation/OnSuccessExample.svelte"
mkdir -p "packages/svelte-query/tests/createMutation"
cp "/tests/packages/svelte-query/tests/createMutation/ResetExample.svelte" "packages/svelte-query/tests/createMutation/ResetExample.svelte"
mkdir -p "packages/svelte-query/tests/createQuery"
cp "/tests/packages/svelte-query/tests/createQuery/PlaceholderData.svelte" "packages/svelte-query/tests/createQuery/PlaceholderData.svelte"
mkdir -p "packages/svelte-query/tests/useIsMutating"
cp "/tests/packages/svelte-query/tests/useIsMutating/BaseExample.svelte" "packages/svelte-query/tests/useIsMutating/BaseExample.svelte"
mkdir -p "packages/svelte-query/tests/useMutationState"
cp "/tests/packages/svelte-query/tests/useMutationState/BaseExample.svelte" "packages/svelte-query/tests/useMutationState/BaseExample.svelte"
mkdir -p "packages/svelte-query/tests/useMutationState"
cp "/tests/packages/svelte-query/tests/useMutationState/useMutationState.test.ts" "packages/svelte-query/tests/useMutationState/useMutationState.test.ts"

# Reset NX cache to avoid cache integrity issues after copying files
npx nx reset

# Rebuild after copying test files (to update compiled output)
pnpm run build:all

# Run the specific test files for this PR
# The .svelte files are fixtures used by the corresponding .test.ts files

# Run svelte-query tests
cd /app/src/packages/svelte-query
pnpm run test:lib tests/createInfiniteQuery/createInfiniteQuery.test.ts tests/createMutation/createMutation.test.ts tests/createQuery/createQuery.svelte.test.ts tests/useIsMutating/useIsMutating.test.ts tests/useMutationState/useMutationState.test.ts --coverage.enabled=false
svelte_query_status=$?

# Run svelte-query-persist-client tests
cd /app/src/packages/svelte-query-persist-client
pnpm run test:lib tests/PersistQueryClientProvider.svelte.test.ts --coverage.enabled=false
persist_client_status=$?

# Combine test results
if [ $svelte_query_status -eq 0 ] && [ $persist_client_status -eq 0 ]; then
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
