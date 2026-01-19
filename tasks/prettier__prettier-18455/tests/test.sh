#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/css/custom-properties/__snapshots__"
cp "/tests/format/css/custom-properties/__snapshots__/format.test.js.snap" "tests/format/css/custom-properties/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/css/custom-properties"
cp "/tests/format/css/custom-properties/emoji.css" "tests/format/css/custom-properties/emoji.css"
mkdir -p "tests/format/js/import/__snapshots__"
cp "/tests/format/js/import/__snapshots__/format.test.js.snap" "tests/format/js/import/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/import/empty-import/__snapshots__"
cp "/tests/format/js/import/empty-import/__snapshots__/format.test.js.snap" "tests/format/js/import/empty-import/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/import/empty-import"
cp "/tests/format/js/import/empty-import/empty-import-2.js" "tests/format/js/import/empty-import/empty-import-2.js"
mkdir -p "tests/format/js/import/empty-import"
cp "/tests/format/js/import/empty-import/empty-import.js" "tests/format/js/import/empty-import/empty-import.js"
mkdir -p "tests/format/js/import/empty-import"
cp "/tests/format/js/import/empty-import/format.test.js" "tests/format/js/import/empty-import/format.test.js"

# Run the specific test files for CSS custom properties and JS import formatting
# Using --maxWorkers=1 to avoid resource issues when running multiple test suites
npx jest tests/format/css/custom-properties/format.test.js tests/format/js/import/empty-import/format.test.js --coverage=false --maxWorkers=1
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
