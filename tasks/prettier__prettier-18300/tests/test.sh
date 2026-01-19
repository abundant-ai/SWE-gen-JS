#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/js/explicit-resource-management/__snapshots__"
cp "/tests/format/js/explicit-resource-management/__snapshots__/format.test.js.snap" "tests/format/js/explicit-resource-management/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/for/__snapshots__"
cp "/tests/format/js/for/__snapshots__/format.test.js.snap" "tests/format/js/for/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/js/for"
cp "/tests/format/js/for/no-update.js" "tests/format/js/for/no-update.js"

# Run the specific test files for this PR
# Snapshots are updated by running the corresponding format.test.js files
npx jest tests/format/js/explicit-resource-management/format.test.js tests/format/js/for/format.test.js --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
