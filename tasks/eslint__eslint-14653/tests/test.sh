#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/no-empty-character-class.js" "tests/lib/rules/no-empty-character-class.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/no-invalid-regexp.js" "tests/lib/rules/no-invalid-regexp.js"

# Run specific test files using mocha with increased timeout
npx mocha --timeout 10000 \
  tests/lib/rules/no-empty-character-class.js \
  tests/lib/rules/no-invalid-regexp.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
