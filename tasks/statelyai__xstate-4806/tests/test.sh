#!/bin/bash

cd /app/src

# Set Node memory limit to avoid OOM in constrained environments
export NODE_OPTIONS="--max-old-space-size=3072"

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/setup.types.test.ts" "packages/core/test/setup.types.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/types.test.ts" "packages/core/test/types.test.ts"

# For type tests, we need to run TypeScript compiler to check for type errors
# The test files themselves contain code that should fail to compile in the buggy state
yarn tsc --noEmit
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
