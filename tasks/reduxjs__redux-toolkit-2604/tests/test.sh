#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/createAsyncThunk.typetest.ts" "packages/toolkit/src/tests/createAsyncThunk.typetest.ts"

# Run TypeScript type checking on the specific test file
cd packages/toolkit
npx tsc -p src/tests --noEmit
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
