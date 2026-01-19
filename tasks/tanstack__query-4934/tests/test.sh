#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/vue-query/src/__tests__"
cp "/tests/packages/vue-query/src/__tests__/queryCache.test.ts" "packages/vue-query/src/__tests__/queryCache.test.ts"
mkdir -p "packages/vue-query/src/__tests__"
cp "/tests/packages/vue-query/src/__tests__/useQueries.test.ts" "packages/vue-query/src/__tests__/useQueries.test.ts"
mkdir -p "packages/vue-query/src/__tests__"
cp "/tests/packages/vue-query/src/__tests__/vueQueryPlugin.test.ts" "packages/vue-query/src/__tests__/vueQueryPlugin.test.ts"

# Run the specific test files with jest (disable coverage)
cd /app/src/packages/vue-query
NODE_OPTIONS="--max-old-space-size=2048" npx jest src/__tests__/queryCache.test.ts src/__tests__/useQueries.test.ts src/__tests__/vueQueryPlugin.test.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
