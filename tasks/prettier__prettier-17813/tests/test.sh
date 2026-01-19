#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/markdown/table/__snapshots__"
cp "/tests/format/markdown/table/__snapshots__/format.test.js.snap" "tests/format/markdown/table/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/markdown/table"
cp "/tests/format/markdown/table/issue-15572.md" "tests/format/markdown/table/issue-15572.md"
mkdir -p "tests/integration/__tests__"
cp "/tests/integration/__tests__/util-shared.js" "tests/integration/__tests__/util-shared.js"

# Run the specific tests for this PR (tests/format/markdown/table/ and tests/integration/__tests__/util-shared.js)
npx jest tests/format/markdown/table tests/integration/__tests__/util-shared.js --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
