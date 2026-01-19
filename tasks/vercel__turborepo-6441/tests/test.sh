#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/turbo-repository/__tests__"
cp "/tests/packages/turbo-repository/__tests__/find.test.ts" "packages/turbo-repository/__tests__/find.test.ts"

# Run Jest test for the specific test file
cd packages/turbo-repository
npx jest __tests__/find.test.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
