#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/types.test.ts" "packages/core/test/types.test.ts"

# Check types using tsc on the packages/core directory
# This will properly resolve all imports and check type constraints
# We grep for TS2578 errors (unused @ts-expect-error) in our specific test file
set +o pipefail
cd packages/core && npx tsc --noEmit 2>&1 | grep -E "test/types.test.ts.*error TS2578"
grep_exit=$?
set -o pipefail

# If grep finds TS2578 errors in types.test.ts, the test failed (buggy state)
# If grep finds no such errors, the test passed (fixed state)
if [ $grep_exit -eq 0 ]; then
  test_status=1
else
  test_status=0
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
