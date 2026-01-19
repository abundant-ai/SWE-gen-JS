#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/no-array-constructor.js" "tests/lib/rules/no-array-constructor.js"

# Run the specific test files using mocha
npx mocha \
  tests/lib/rules/no-array-constructor.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
