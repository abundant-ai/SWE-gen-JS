#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/lib/linter"
cp "/tests/lib/linter/linter.js" "tests/lib/linter/linter.js"
mkdir -p "tests/lib/source-code"
cp "/tests/lib/source-code/source-code.js" "tests/lib/source-code/source-code.js"

# Run the specific test files using mocha
npx mocha \
  tests/lib/linter/linter.js \
  tests/lib/source-code/source-code.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
