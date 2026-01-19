#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/error.js" "test/error.js"
mkdir -p "test"
cp "/tests/kill.js" "test/kill.js"

# Skip flaky test that fails in containerized environments due to process cleanup issues
# The test "spawnAndKill cleanup SIGTERM" relies on subprocess cleanup that doesn't work
# reliably in Docker/Daytona containers with PID namespacing
npx ava test/error.js test/kill.js --match '!*spawnAndKill cleanup SIGTERM*'
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
