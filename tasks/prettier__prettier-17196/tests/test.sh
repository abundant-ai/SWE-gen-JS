#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/flow/conditional-types/parentheses/__snapshots__"
cp "/tests/format/flow/conditional-types/parentheses/__snapshots__/format.test.js.snap" "tests/format/flow/conditional-types/parentheses/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/flow/conditional-types/parentheses"
cp "/tests/format/flow/conditional-types/parentheses/format.test.js" "tests/format/flow/conditional-types/parentheses/format.test.js"
mkdir -p "tests/format/flow/conditional-types/parentheses"
cp "/tests/format/flow/conditional-types/parentheses/union.js" "tests/format/flow/conditional-types/parentheses/union.js"

# Run the specific tests for this PR (tests in tests/format/flow/conditional-types/parentheses/)
npx jest tests/format/flow/conditional-types/parentheses --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
