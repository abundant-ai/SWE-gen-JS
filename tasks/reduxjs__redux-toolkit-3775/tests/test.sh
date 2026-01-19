#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/toolkit/src/listenerMiddleware/tests"
cp "/tests/packages/toolkit/src/listenerMiddleware/tests/listenerMiddleware.test.ts" "packages/toolkit/src/listenerMiddleware/tests/listenerMiddleware.test.ts"

# Run specific test file with jest
cd packages/toolkit
npx jest src/listenerMiddleware/tests/listenerMiddleware.test.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
