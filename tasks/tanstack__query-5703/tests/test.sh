#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/vue-query/src/__tests__"
cp "/tests/packages/vue-query/src/__tests__/useQueryClient.test.ts" "packages/vue-query/src/__tests__/useQueryClient.test.ts"

# Run the specific test file using jest (the project's test runner for vue-query)
cd /app/src/packages/vue-query
npx jest src/__tests__/useQueryClient.test.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
