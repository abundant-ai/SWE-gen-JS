#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/fixtures"
cp "/tests/fixtures/bad-examples.md" "tests/fixtures/bad-examples.md"
mkdir -p "tests/fixtures"
cp "/tests/fixtures/good-examples.md" "tests/fixtures/good-examples.md"
mkdir -p "tests/tools"
cp "/tests/tools/check-rule-examples.js" "tests/tools/check-rule-examples.js"

# Run the specific test files using mocha
npx mocha \
  tests/tools/check-rule-examples.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
