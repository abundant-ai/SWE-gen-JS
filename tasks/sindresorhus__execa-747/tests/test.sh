#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/fixtures"
cp "/tests/fixtures/noop-fd-ipc.js" "test/fixtures/noop-fd-ipc.js"
chmod +x "test/fixtures/noop-fd-ipc.js"
mkdir -p "test"
cp "/tests/stream.js" "test/stream.js"

# Run the specific test files using AVA
npx ava test/stream.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
