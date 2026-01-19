#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/js/comments/__snapshots__"
cp "/tests/format/js/comments/__snapshots__/format.test.js.snap" "tests/format/js/comments/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/comments"
cp "/tests/format/js/comments/return-statement-2.js" "tests/format/js/comments/return-statement-2.js"
mkdir -p "tests/format/js/comments"
cp "/tests/format/js/comments/return-statement.js" "tests/format/js/comments/return-statement.js"

# Run the specific test files for this PR
# Snapshots are updated by running the corresponding format.test.js file
npx jest tests/format/js/comments/format.test.js --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
