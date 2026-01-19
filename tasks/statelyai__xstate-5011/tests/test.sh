#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/actions.test.ts" "packages/core/test/actions.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/types.test.ts" "packages/core/test/types.test.ts"

# Run TypeScript type-check to catch type errors (this is a type-level fix)
yarn typecheck 2>&1 | head -100
test_status=${PIPESTATUS[0]}

# Only run tests if typecheck succeeded
if [ $test_status -eq 0 ]; then
  yarn jest packages/core/test/actions.test.ts packages/core/test/types.test.ts --coverage=false
  test_status=$?
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
