#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/autoBatchEnhancer.test.ts" "packages/toolkit/src/tests/autoBatchEnhancer.test.ts"

# Run the specific tests for this PR
cd packages/toolkit
yarn test src/tests/autoBatchEnhancer.test.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
