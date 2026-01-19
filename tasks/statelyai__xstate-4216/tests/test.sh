#!/bin/bash

set -o pipefail

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state with object-syntax versions)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/after.test.ts" "packages/core/test/after.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/interpreter.test.ts" "packages/core/test/interpreter.test.ts"

# Check if smoke.test.ts exists (it's added by bug.patch, deleted by fix.patch)
if [ -f "packages/core/test/smoke.test.ts" ]; then
  # BASE state: smoke.test.ts exists and tests that arrays work
  # This indicates buggy behavior (array support should not exist)
  echo "ERROR: smoke.test.ts should not exist in fixed state" >&2
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi

# Run tests that should pass in FIXED state (using object syntax)
yarn jest packages/core/test/after.test.ts packages/core/test/interpreter.test.ts --coverage=false

test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
