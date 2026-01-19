#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/js/multiparser-css/__snapshots__"
cp "/tests/format/js/multiparser-css/__snapshots__/format.test.js.snap" "tests/format/js/multiparser-css/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/multiparser-css"
cp "/tests/format/js/multiparser-css/issue-16692.js" "tests/format/js/multiparser-css/issue-16692.js"

# Run the specific test for this PR (tests/format/js/multiparser-css)
npx jest tests/format/js/multiparser-css --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
