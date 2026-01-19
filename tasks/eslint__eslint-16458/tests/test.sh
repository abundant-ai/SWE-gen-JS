#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/comma-dangle.js" "tests/lib/rules/comma-dangle.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/func-name-matching.js" "tests/lib/rules/func-name-matching.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/no-misleading-character-class.js" "tests/lib/rules/no-misleading-character-class.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/prefer-regex-literals.js" "tests/lib/rules/prefer-regex-literals.js"

# Run the specific test files for this PR
npx mocha tests/lib/rules/comma-dangle.js tests/lib/rules/func-name-matching.js tests/lib/rules/no-misleading-character-class.js tests/lib/rules/prefer-regex-literals.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
