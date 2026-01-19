#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/object.ts" "test/object.ts"
mkdir -p "test/types"
cp "/tests/types/types.ts" "test/types/types.ts"

# Run Jest on test/object.ts (disable coverage to run subset)
npx jest test/object.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
