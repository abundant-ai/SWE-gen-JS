#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/fixtures"
cp "/tests/fixtures/command with space" "test/fixtures/command with space"
mkdir -p "test/fixtures"
cp "/tests/fixtures/delay" "test/fixtures/delay"
mkdir -p "test/fixtures"
cp "/tests/fixtures/detach" "test/fixtures/detach"
mkdir -p "test/fixtures"
cp "/tests/fixtures/echo" "test/fixtures/echo"
mkdir -p "test/fixtures"
cp "/tests/fixtures/environment" "test/fixtures/environment"
mkdir -p "test/fixtures"
cp "/tests/fixtures/exit" "test/fixtures/exit"
mkdir -p "test/fixtures"
cp "/tests/fixtures/fail" "test/fixtures/fail"
mkdir -p "test/fixtures"
cp "/tests/fixtures/fast-exit-darwin" "test/fixtures/fast-exit-darwin"
mkdir -p "test/fixtures"
cp "/tests/fixtures/fast-exit-linux" "test/fixtures/fast-exit-linux"
mkdir -p "test/fixtures"
cp "/tests/fixtures/forever" "test/fixtures/forever"
mkdir -p "test/fixtures"
cp "/tests/fixtures/hello.cmd" "test/fixtures/hello.cmd"
mkdir -p "test/fixtures"
cp "/tests/fixtures/hello.sh" "test/fixtures/hello.sh"
mkdir -p "test/fixtures"
cp "/tests/fixtures/max-buffer" "test/fixtures/max-buffer"
mkdir -p "test/fixtures"
cp "/tests/fixtures/no-killable" "test/fixtures/no-killable"
mkdir -p "test/fixtures"
cp "/tests/fixtures/non-executable" "test/fixtures/non-executable"
mkdir -p "test/fixtures"
cp "/tests/fixtures/noop" "test/fixtures/noop"
mkdir -p "test/fixtures"
cp "/tests/fixtures/noop-132" "test/fixtures/noop-132"
mkdir -p "test/fixtures"
cp "/tests/fixtures/noop-err" "test/fixtures/noop-err"
mkdir -p "test/fixtures"
cp "/tests/fixtures/noop-throw" "test/fixtures/noop-throw"
mkdir -p "test/fixtures"
cp "/tests/fixtures/send" "test/fixtures/send"
mkdir -p "test/fixtures"
cp "/tests/fixtures/stdin" "test/fixtures/stdin"
mkdir -p "test/fixtures"
cp "/tests/fixtures/sub-process" "test/fixtures/sub-process"
mkdir -p "test/fixtures"
cp "/tests/fixtures/sub-process-exit" "test/fixtures/sub-process-exit"

# Copy the HEAD version of test/node.js (which tests the execa.node() feature)
mkdir -p "test"
cp "/tests/node.js" "test/node.js"

# Run the specific test file for this PR using AVA
npx ava --timeout=60s test/node.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
