#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/guards.test.ts" "packages/core/test/guards.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/stateIn.test.ts" "packages/core/test/stateIn.test.ts"

# Run Jest on the specific test files for this PR
npx jest packages/core/test/guards.test.ts packages/core/test/stateIn.test.ts --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
