#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "src/__tests__/utils"
cp "/tests/src/__tests__/utils/set.test.ts" "src/__tests__/utils/set.test.ts"

# Run specific test files with Jest (disable coverage to avoid thresholds)
pnpm test -- src/__tests__/utils/set.test.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
