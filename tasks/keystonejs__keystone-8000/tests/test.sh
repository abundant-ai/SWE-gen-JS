#!/bin/bash

cd /app/src

export CI=true
export TEST_ADAPTER=sqlite

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/api-tests/relationships"
cp "/tests/api-tests/relationships/to-one-query-batching.test.ts" "tests/api-tests/relationships/to-one-query-batching.test.ts"

# Rebuild the project to pick up any source code changes (e.g., from fix.patch applied by oracle)
yarn build
build_status=$?

if [ $build_status -ne 0 ]; then
  echo 0 > /logs/verifier/reward.txt
  exit $build_status
fi

# Run the specific test file for this PR
yarn jest tests/api-tests/relationships/to-one-query-batching.test.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
