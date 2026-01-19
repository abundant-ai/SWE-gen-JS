#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/js/import-attributes/__snapshots__"
cp "/tests/format/js/import-attributes/__snapshots__/format.test.js.snap" "tests/format/js/import-attributes/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/import-attributes"
cp "/tests/format/js/import-attributes/long-sources.js" "tests/format/js/import-attributes/long-sources.js"
mkdir -p "tests/format/js/import-attributes"
cp "/tests/format/js/import-attributes/multiple.js" "tests/format/js/import-attributes/multiple.js"

# Run the specific tests for this PR (tests in tests/format/js/import-attributes/)
npx jest tests/format/js/import-attributes --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
