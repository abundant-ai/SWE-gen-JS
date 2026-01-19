#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/helpers"
cp "/tests/helpers/fixtures-dir.js" "test/helpers/fixtures-dir.js"
mkdir -p "test"
cp "/tests/test.js" "test/test.js"

# Run the specific test file using AVA
npx ava test/test.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
