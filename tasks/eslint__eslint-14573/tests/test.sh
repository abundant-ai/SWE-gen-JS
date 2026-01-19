#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/fixtures/testers/rule-tester"
cp "/tests/fixtures/testers/rule-tester/suggestions.js" "tests/fixtures/testers/rule-tester/suggestions.js"
mkdir -p "tests/lib/linter"
cp "/tests/lib/linter/linter.js" "tests/lib/linter/linter.js"
mkdir -p "tests/lib/rule-tester"
cp "/tests/lib/rule-tester/rule-tester.js" "tests/lib/rule-tester/rule-tester.js"

# Run specific test files using mocha with increased timeout
npx mocha --timeout 10000 \
  tests/fixtures/testers/rule-tester/suggestions.js \
  tests/lib/linter/linter.js \
  tests/lib/rule-tester/rule-tester.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
