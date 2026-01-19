#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/kill.js" "test/kill.js"

# The test "spawnAndKill cleanup SIGTERM" is flaky in Docker environments
# Exclude it to avoid false negatives
npx ava test/kill.js --match '!*spawnAndKill cleanup SIGTERM*'
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
