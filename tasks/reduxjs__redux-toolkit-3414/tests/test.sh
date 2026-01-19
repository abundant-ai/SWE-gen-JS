#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/actionCreatorInvariantMiddleware.test.ts" "packages/toolkit/src/tests/actionCreatorInvariantMiddleware.test.ts"
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/configureStore.test.ts" "packages/toolkit/src/tests/configureStore.test.ts"
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/getDefaultMiddleware.test.ts" "packages/toolkit/src/tests/getDefaultMiddleware.test.ts"

# Run the specific test files using jest
cd packages/toolkit
npx jest src/tests/actionCreatorInvariantMiddleware.test.ts src/tests/configureStore.test.ts src/tests/getDefaultMiddleware.test.ts --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
