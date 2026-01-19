#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/fixtures"
cp "/tests/fixtures/no-await.js" "test/fixtures/no-await.js"
mkdir -p "test"
cp "/tests/promise.js" "test/promise.js"
mkdir -p "test"
cp "/tests/stream.js" "test/stream.js"

# Make fixture file executable
chmod +x test/fixtures/no-await.js

# Run the specific test files using AVA
npx ava test/promise.js test/stream.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
