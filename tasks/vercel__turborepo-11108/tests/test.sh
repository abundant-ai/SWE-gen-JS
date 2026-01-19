#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/turbo-workspaces/__tests__"
cp "/tests/packages/turbo-workspaces/__tests__/index.test.ts" "packages/turbo-workspaces/__tests__/index.test.ts"

# Run specific test file with Jest (coverage disabled to avoid threshold failures)
cd packages/turbo-workspaces
npx jest __tests__/index.test.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
