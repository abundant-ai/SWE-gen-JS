#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/markdown/cursor"
cp "/tests/format/markdown/cursor/17227.md" "tests/format/markdown/cursor/17227.md"
mkdir -p "tests/format/markdown/cursor/__snapshots__"
cp "/tests/format/markdown/cursor/__snapshots__/format.test.js.snap" "tests/format/markdown/cursor/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/markdown/cursor"
cp "/tests/format/markdown/cursor/format.test.js" "tests/format/markdown/cursor/format.test.js"

# Run the specific tests for this PR (tests in tests/format/markdown/cursor/)
npx jest tests/format/markdown/cursor --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
