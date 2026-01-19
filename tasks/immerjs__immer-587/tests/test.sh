#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "__tests__/flow"
cp "/tests/flow/.flowconfig" "__tests__/flow/.flowconfig"
mkdir -p "__tests__/flow"
cp "/tests/flow/flow.js.flow" "__tests__/flow/flow.js.flow"

# Run Flow type checker on the specific test directory
yarn flow check __tests__/flow
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
