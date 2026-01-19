#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/format/lwc/attribute/quotes/__snapshots__"
cp "/tests/format/lwc/attribute/quotes/__snapshots__/format.test.js.snap" "tests/format/lwc/attribute/quotes/__snapshots__/format.test.js.snap"
mkdir -p "tests/format/lwc/attribute/quotes"
cp "/tests/format/lwc/attribute/quotes/quotes.html" "tests/format/lwc/attribute/quotes/quotes.html"

# Run the specific test files for lwc/attribute/quotes formatting
# Use --runInBand to avoid parallel execution and memory issues
npx jest tests/format/lwc/attribute/quotes/format.test.js --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
