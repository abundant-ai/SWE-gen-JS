#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/fixtures"
cp "/tests/fixtures/no-killable.js" "test/fixtures/no-killable.js"
mkdir -p "test"
cp "/tests/kill.js" "test/kill.js"

# Run only the specific test files using AVA
npx ava test/kill.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
