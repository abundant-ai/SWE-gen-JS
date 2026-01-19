#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/config"
cp "/tests/config/run-format-test.js" "tests/config/run-format-test.js"
mkdir -p "tests/format/markdown/code/__snapshots__"
cp "/tests/format/markdown/code/__snapshots__/format.test.js.snap" "tests/format/markdown/code/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/markdown/spec/__snapshots__"
cp "/tests/format/markdown/spec/__snapshots__/format.test.js.snap" "tests/format/markdown/spec/__snapshots__/format.test.js.snap"

# Run the specific test files for this PR
# Snapshots are updated by running the corresponding format.test.js files
npx jest tests/config/run-format-test.js tests/format/markdown/code/format.test.js tests/format/markdown/spec/format.test.js --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
