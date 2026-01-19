#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/lib/linter"
cp "/tests/lib/linter/linter.js" "tests/lib/linter/linter.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/no-fallthrough.js" "tests/lib/rules/no-fallthrough.js"

# Run the specific test files for this PR (excluding flaky ES6 test)
npx mocha tests/lib/linter/linter.js tests/lib/rules/no-fallthrough.js --grep "ES6 global variables should be available by default" --invert
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
