#!/bin/bash

cd /app/src

# Set Node memory limit to avoid OOM in constrained environments
export NODE_OPTIONS="--max-old-space-size=3072"

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/deterministic.test.ts" "packages/core/test/deterministic.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/getNextSnapshot.test.ts" "packages/core/test/getNextSnapshot.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/invalid.test.ts" "packages/core/test/invalid.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/invoke.test.ts" "packages/core/test/invoke.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/microstep.test.ts" "packages/core/test/microstep.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/utils.ts" "packages/core/test/utils.ts"

# Run the specific test files with Jest
npx jest packages/core/test/deterministic.test.ts packages/core/test/getNextSnapshot.test.ts packages/core/test/invalid.test.ts packages/core/test/invoke.test.ts packages/core/test/microstep.test.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
