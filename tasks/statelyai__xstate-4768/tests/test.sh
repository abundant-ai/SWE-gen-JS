#!/bin/bash

cd /app/src

# Set Node memory limit to avoid OOM in constrained environments
export NODE_OPTIONS="--max-old-space-size=3072"

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/final.test.ts" "packages/core/test/final.test.ts"

# Run the specific test file with Jest
npx jest packages/core/test/final.test.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
