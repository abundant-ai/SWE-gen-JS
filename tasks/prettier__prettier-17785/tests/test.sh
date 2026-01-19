#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/typescript/mapped-type/__snapshots__"
cp "/tests/format/typescript/mapped-type/__snapshots__/format.test.js.snap" "tests/format/typescript/mapped-type/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/typescript/mapped-type"
cp "/tests/format/typescript/mapped-type/issue-17784.ts" "tests/format/typescript/mapped-type/issue-17784.ts"

# Run the specific tests for this PR (tests/format/typescript/mapped-type/)
npx jest tests/format/typescript/mapped-type --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
