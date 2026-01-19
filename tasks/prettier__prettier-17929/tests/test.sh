#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/css/modules/__snapshots__"
cp "/tests/format/css/modules/__snapshots__/format.test.js.snap" "tests/format/css/modules/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/css/modules"
cp "/tests/format/css/modules/modules.css" "tests/format/css/modules/modules.css"

# Run the specific tests for this PR (tests/format/css/modules)
npx jest tests/format/css/modules --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
