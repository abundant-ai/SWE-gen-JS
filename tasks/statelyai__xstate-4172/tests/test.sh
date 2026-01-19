#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/actor.test.ts" "packages/core/test/actor.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/interpreter.test.ts" "packages/core/test/interpreter.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/invoke.test.ts" "packages/core/test/invoke.test.ts"

# Run Jest on the specific test files (disable coverage to avoid thresholds)
npx jest packages/core/test/actor.test.ts packages/core/test/interpreter.test.ts packages/core/test/invoke.test.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
