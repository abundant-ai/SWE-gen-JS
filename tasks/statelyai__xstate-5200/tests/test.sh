#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/xstate-store/src"
cp "/tests/packages/xstate-store/src/select.test.ts" "packages/xstate-store/src/select.test.ts"

# Run jest on the specific test file
pnpm exec jest packages/xstate-store/src/select.test.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
