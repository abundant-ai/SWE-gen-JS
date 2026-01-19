#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "__tests__/types"
cp "/tests/types/type-externals.ts" "__tests__/types/type-externals.ts"

# Run Jest on the specific test file (disable coverage for subset testing)
npx jest __tests__/types/type-externals.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
