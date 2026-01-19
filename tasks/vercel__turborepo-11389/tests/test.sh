#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/turbo-utils/__tests__"
cp "/tests/packages/turbo-utils/__tests__/examples.test.ts" "packages/turbo-utils/__tests__/examples.test.ts"

# Run specific test file with Jest (coverage disabled to avoid threshold failures)
cd packages/turbo-utils
npx jest __tests__/examples.test.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
