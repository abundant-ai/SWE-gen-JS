#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/markdown/wiki-link/__snapshots__"
cp "/tests/format/markdown/wiki-link/__snapshots__/format.test.js.snap" "tests/format/markdown/wiki-link/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/markdown/wiki-link"
cp "/tests/format/markdown/wiki-link/multi-line.md" "tests/format/markdown/wiki-link/multi-line.md"

# Run the specific test files for markdown wiki-link formatting
# Use --runInBand to avoid parallel execution and memory issues
npx jest tests/format/markdown/wiki-link/format.test.js --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
