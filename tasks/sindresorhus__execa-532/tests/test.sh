#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/fixtures"
cp "/tests/fixtures/nested.js" "test/fixtures/nested.js"
chmod +x "test/fixtures/nested.js"
mkdir -p "test/fixtures"
cp "/tests/fixtures/verbose-script.js" "test/fixtures/verbose-script.js"
chmod +x "test/fixtures/verbose-script.js"
mkdir -p "test"
cp "/tests/verbose.js" "test/verbose.js"

npx ava test/verbose.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
