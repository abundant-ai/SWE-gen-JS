#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/error.js" "test/error.js"
mkdir -p "test/fixtures"
cp "/tests/fixtures/echo-fail" "test/fixtures/echo-fail"
chmod +x "test/fixtures/echo-fail"

npx ava test/error.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
