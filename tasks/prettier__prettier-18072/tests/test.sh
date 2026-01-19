#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/integration/__tests__"
cp "/tests/integration/__tests__/plugin-override-builtin-printers.js" "tests/integration/__tests__/plugin-override-builtin-printers.js"

# Run the specific test file for this PR
npx jest tests/integration/__tests__/plugin-override-builtin-printers.js --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
