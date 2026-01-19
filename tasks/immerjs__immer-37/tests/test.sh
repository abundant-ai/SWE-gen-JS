#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "__tests__"
cp "/tests/curry.js" "__tests__/curry.js"
mkdir -p "__tests__"
cp "/tests/frozen.js" "__tests__/frozen.js"

# Run Jest test for the specific test file (curry.js is the main feature test)
# Note: frozen.js was updated but only for renaming immer->produce, not for testing curry functionality
npx jest __tests__/curry.js --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
