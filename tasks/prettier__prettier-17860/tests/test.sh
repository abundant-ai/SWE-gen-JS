#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/unit"
cp "/tests/unit/ast-path.js" "tests/unit/ast-path.js"

# Run the specific tests for this PR (tests/unit/ast-path.js)
npx jest tests/unit/ast-path --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
