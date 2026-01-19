#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/markdown/commonmark-test-suite/__snapshots__"
cp "/tests/format/markdown/commonmark-test-suite/__snapshots__/format.test.js.snap" "tests/format/markdown/commonmark-test-suite/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/markdown/link/__snapshots__"
cp "/tests/format/markdown/link/__snapshots__/format.test.js.snap" "tests/format/markdown/link/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/markdown/link"
cp "/tests/format/markdown/link/escape-in-link.md" "tests/format/markdown/link/escape-in-link.md"

# Run the specific test files for markdown link and commonmark formatting
# Use --runInBand to avoid parallel execution and memory issues
npx jest tests/format/markdown/link/format.test.js tests/format/markdown/commonmark-test-suite/format.test.js --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
