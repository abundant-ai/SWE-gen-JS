#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/rtk-codemods/transforms/createSliceReducerBuilder"
cp "/tests/packages/rtk-codemods/transforms/createSliceReducerBuilder/createSliceReducerBuilder.test.ts" "packages/rtk-codemods/transforms/createSliceReducerBuilder/createSliceReducerBuilder.test.ts"

# Run the specific test file for rtk-codemods
cd packages/rtk-codemods
npx vitest run transforms/createSliceReducerBuilder/createSliceReducerBuilder.test.ts --no-coverage
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
