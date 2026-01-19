#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/deterministic.test.ts" "packages/core/test/deterministic.test.ts"
mkdir -p "packages/core/test/examples"
cp "/tests/packages/core/test/examples/6.16.test.ts" "packages/core/test/examples/6.16.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/interpreter.test.ts" "packages/core/test/interpreter.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/state.test.ts" "packages/core/test/state.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/utils.ts" "packages/core/test/utils.ts"

# Run Jest on the specific test files for this PR (excluding xstate-inspect due to module issues)
npx jest packages/core/test/deterministic.test.ts packages/core/test/examples/6.16.test.ts packages/core/test/interpreter.test.ts packages/core/test/state.test.ts --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
