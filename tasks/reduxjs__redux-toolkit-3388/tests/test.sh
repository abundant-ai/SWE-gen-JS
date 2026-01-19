#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/createSlice.test.ts" "packages/toolkit/src/tests/createSlice.test.ts"
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/createSlice.typetest.ts" "packages/toolkit/src/tests/createSlice.typetest.ts"

# Run the specific test files using vitest
cd packages/toolkit
npx vitest run src/tests/createSlice.test.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
