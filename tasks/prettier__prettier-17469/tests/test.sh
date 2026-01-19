#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/js/assignment/__snapshots__"
cp "/tests/format/js/assignment/__snapshots__/format.test.js.snap" "tests/format/js/assignment/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/assignment"
cp "/tests/format/js/assignment/issue-17437.js" "tests/format/js/assignment/issue-17437.js"

# Run the specific test for this PR (tests/format/js/assignment)
npx jest tests/format/js/assignment --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
