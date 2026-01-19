#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/error.js" "test/error.js"
mkdir -p "test/fixtures"
cp "/tests/fixtures/max-buffer" "test/fixtures/max-buffer"
mkdir -p "test"
cp "/tests/stream.js" "test/stream.js"

npx ava --timeout=60s test/error.js test/stream.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
