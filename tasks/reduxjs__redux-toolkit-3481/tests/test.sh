#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/toolkit/src/entities/tests"
cp "/tests/packages/toolkit/src/entities/tests/state_selectors.test.ts" "packages/toolkit/src/entities/tests/state_selectors.test.ts"

# Run the specific test file from the toolkit package directory
cd packages/toolkit
npx vitest run src/entities/tests/state_selectors.test.ts --no-coverage
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
