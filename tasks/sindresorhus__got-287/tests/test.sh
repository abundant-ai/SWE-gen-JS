#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/cancel.js" "test/cancel.js"

# Run only the specific test files for this PR using AVA
# Capture output to check if tests pass even if there are unhandled rejections
output=$(npx ava test/cancel.js 2>&1)
test_status=$?
echo "$output"

# Check if both tests passed (the cancel tests may have unhandled rejection issues
# due to server cleanup, but the tests themselves pass)
if echo "$output" | grep -q "2 tests passed"; then
  echo 1 > /logs/verifier/reward.txt
  exit 0
elif [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
  exit 0
else
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi
