#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/toolkit/src/tests/__snapshots__"
cp "/tests/packages/toolkit/src/tests/__snapshots__/serializableStateInvariantMiddleware.test.ts.snap" "packages/toolkit/src/tests/__snapshots__/serializableStateInvariantMiddleware.test.ts.snap"
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/immutableStateInvariantMiddleware.test.ts" "packages/toolkit/src/tests/immutableStateInvariantMiddleware.test.ts"
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/serializableStateInvariantMiddleware.test.ts" "packages/toolkit/src/tests/serializableStateInvariantMiddleware.test.ts"

# Run the specific tests for this PR
cd packages/toolkit
yarn test src/tests/immutableStateInvariantMiddleware.test.ts src/tests/serializableStateInvariantMiddleware.test.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
