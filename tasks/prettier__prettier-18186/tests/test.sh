#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/typescript/union/comments"
cp "/tests/format/typescript/union/comments/18106.ts" "tests/format/typescript/union/comments/18106.ts"
mkdir -p "tests/format/typescript/union/comments/__snapshots__"
cp "/tests/format/typescript/union/comments/__snapshots__/format.test.js.snap" "tests/format/typescript/union/comments/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/typescript/union/consistent-with-flow/__snapshots__"
cp "/tests/format/typescript/union/consistent-with-flow/__snapshots__/format.test.js.snap" "tests/format/typescript/union/consistent-with-flow/__snapshots__/format.test.js.snap"

# Run the specific test files for this PR
# Snapshots are updated by running the corresponding format.test.js files
npx jest tests/format/typescript/union/comments/format.test.js tests/format/typescript/union/consistent-with-flow/format.test.js --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
