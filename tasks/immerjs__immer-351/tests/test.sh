#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "__tests__"
cp "/tests/base.js" "__tests__/base.js"
mkdir -p "__tests__"
cp "/tests/patch.js" "__tests__/patch.js"

# Run Jest on the specific test files from this PR
yarn jest __tests__/base.js __tests__/patch.js --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
