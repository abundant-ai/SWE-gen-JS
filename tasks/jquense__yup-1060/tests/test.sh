#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/.eslintignore" "test/.eslintignore"
mkdir -p "test"
cp "/tests/yup.js" "test/yup.js"

# Run lint to catch syntax errors and unused imports
yarn lint
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
