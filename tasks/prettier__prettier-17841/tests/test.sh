#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/css/attribute/__snapshots__"
cp "/tests/format/css/attribute/__snapshots__/format.test.js.snap" "tests/format/css/attribute/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/css/attribute"
cp "/tests/format/css/attribute/sensitive.css" "tests/format/css/attribute/sensitive.css"

# Run the specific tests for this PR (tests/format/css/attribute/)
npx jest tests/format/css/attribute --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
