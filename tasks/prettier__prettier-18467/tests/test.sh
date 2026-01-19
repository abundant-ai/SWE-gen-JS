#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/markdown/commonmark-test-suite/__snapshots__"
cp "/tests/format/markdown/commonmark-test-suite/__snapshots__/format.test.js.snap" "tests/format/markdown/commonmark-test-suite/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/markdown/html/__snapshots__"
cp "/tests/format/markdown/html/__snapshots__/format.test.js.snap" "tests/format/markdown/html/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/markdown/html"
cp "/tests/format/markdown/html/multiline-attribute.md" "tests/format/markdown/html/multiline-attribute.md"
mkdir -p "tests/format/markdown/markdown/__snapshots__"
cp "/tests/format/markdown/markdown/__snapshots__/format.test.js.snap" "tests/format/markdown/markdown/__snapshots__/format.test.js.snap"

# Run the specific test files that test markdown formatting
# Using --maxWorkers=1 to avoid resource issues when running multiple test suites
npx jest tests/format/markdown/commonmark-test-suite/format.test.js tests/format/markdown/html/format.test.js tests/format/markdown/markdown/format.test.js --coverage=false --maxWorkers=1
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
