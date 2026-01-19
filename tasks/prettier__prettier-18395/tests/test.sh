#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/typescript/union/comments"
cp "/tests/format/typescript/union/comments/18379.ts" "tests/format/typescript/union/comments/18379.ts"
mkdir -p "tests/format/typescript/union/comments/__snapshots__"
cp "/tests/format/typescript/union/comments/__snapshots__/format.test.js.snap" "tests/format/typescript/union/comments/__snapshots__/format.test.js.snap"

# Run the specific test files for typescript/union/comments formatting
# Use --runInBand to avoid parallel execution and memory issues
npx jest tests/format/typescript/union/comments/format.test.js --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
