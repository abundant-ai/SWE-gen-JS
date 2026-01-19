#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/yaml/block-value/__snapshots__"
cp "/tests/format/yaml/block-value/__snapshots__/format.test.js.snap" "tests/format/yaml/block-value/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/yaml/block-value"
cp "/tests/format/yaml/block-value/format.test.js" "tests/format/yaml/block-value/format.test.js"
mkdir -p "tests/format/yaml/yaml-test-suite/__snapshots__"
cp "/tests/format/yaml/yaml-test-suite/__snapshots__/format.test.js.snap" "tests/format/yaml/yaml-test-suite/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/yaml/yaml-test-suite"
cp "/tests/format/yaml/yaml-test-suite/format.test.js" "tests/format/yaml/yaml-test-suite/format.test.js"

# Run the specific test files for YAML block-value and yaml-test-suite formatting
# Use --runInBand to avoid parallel execution and memory issues
npx jest tests/format/yaml/block-value/format.test.js tests/format/yaml/yaml-test-suite/format.test.js --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
