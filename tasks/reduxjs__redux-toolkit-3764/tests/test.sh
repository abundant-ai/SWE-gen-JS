#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/rtk-codemods/transforms/createReducerBuilder"
cp "/tests/packages/rtk-codemods/transforms/createReducerBuilder/createReducerBuilder.test.ts" "packages/rtk-codemods/transforms/createReducerBuilder/createReducerBuilder.test.ts"
mkdir -p "packages/rtk-codemods/transforms/createSliceBuilder"
cp "/tests/packages/rtk-codemods/transforms/createSliceBuilder/createSliceBuilder.test.ts" "packages/rtk-codemods/transforms/createSliceBuilder/createSliceBuilder.test.ts"

# Run specific test files with vitest (--no-coverage to avoid missing coverage deps)
# Note: fix.patch must create transformTestUtils.ts and vitest.config.ts for tests to pass
cd packages/rtk-codemods
npx vitest run transforms/createReducerBuilder/createReducerBuilder.test.ts transforms/createSliceBuilder/createSliceBuilder.test.ts --no-coverage
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
