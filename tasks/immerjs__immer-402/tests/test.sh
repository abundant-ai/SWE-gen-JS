#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "__tests__"
cp "/tests/curry.js" "__tests__/curry.js"
mkdir -p "__tests__"
cp "/tests/readme.js" "__tests__/readme.js"

# Run Jest on the specific test files from this PR
yarn jest __tests__/curry.js __tests__/readme.js --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
