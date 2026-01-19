#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/retry.js" "test/retry.js"
mkdir -p "test"
cp "/tests/timeout.js" "test/timeout.js"

# Run only the specific test files for this PR using AVA
npx ava test/retry.js test/timeout.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
