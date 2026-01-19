#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/toolkit/src/query/tests"
cp "/tests/packages/toolkit/src/query/tests/optimisticUpdates.test.tsx" "packages/toolkit/src/query/tests/optimisticUpdates.test.tsx"

# Run the specific test file using jest
cd packages/toolkit
yarn test src/query/tests/optimisticUpdates.test.tsx
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
