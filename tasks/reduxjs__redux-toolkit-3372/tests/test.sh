#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/toolkit/src/listenerMiddleware/tests"
cp "/tests/packages/toolkit/src/listenerMiddleware/tests/fork.test.ts" "packages/toolkit/src/listenerMiddleware/tests/fork.test.ts"
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/createAction.test.ts" "packages/toolkit/src/tests/createAction.test.ts"

# Run the specific test files using jest
cd packages/toolkit
npx jest src/listenerMiddleware/tests/fork.test.ts src/tests/createAction.test.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
