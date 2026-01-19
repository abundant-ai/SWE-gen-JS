#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/unit/__snapshots__"
cp "/tests/unit/__snapshots__/visitor-keys.js.snap" "tests/unit/__snapshots__/visitor-keys.js.snap"

# Run the specific test file for visitor-keys unit test
# Use --runInBand to avoid parallel execution and memory issues
npx jest tests/unit/visitor-keys.js --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
