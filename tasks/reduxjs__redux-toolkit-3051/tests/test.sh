#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/createReducer.test.ts" "packages/toolkit/src/tests/createReducer.test.ts"
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/createReducer.typetest.ts" "packages/toolkit/src/tests/createReducer.typetest.ts"
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/createSlice.test.ts" "packages/toolkit/src/tests/createSlice.test.ts"

# Run the specific tests for this PR
cd packages/toolkit
yarn test src/tests/createReducer.test.ts src/tests/createReducer.typetest.ts src/tests/createSlice.test.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
