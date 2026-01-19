#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/lib/linter"
cp "/tests/lib/linter/apply-disable-directives.js" "tests/lib/linter/apply-disable-directives.js"
mkdir -p "tests/lib/linter"
cp "/tests/lib/linter/linter.js" "tests/lib/linter/linter.js"

# Run the specific test files using mocha
npx mocha \
  tests/lib/linter/apply-disable-directives.js \
  tests/lib/linter/linter.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
