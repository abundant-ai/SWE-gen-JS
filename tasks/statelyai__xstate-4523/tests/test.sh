#!/bin/bash

set -o pipefail

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/setup.types.test.ts" "packages/core/test/setup.types.test.ts"

# Run type checking on the entire project
# This will fail if the test file has type errors due to the buggy types
yarn typecheck 2>&1 | head -200
test_status=${PIPESTATUS[0]}

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
