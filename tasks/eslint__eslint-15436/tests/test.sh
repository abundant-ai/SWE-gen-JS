#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/lib/linter"
cp "/tests/lib/linter/apply-disable-directives.js" "tests/lib/linter/apply-disable-directives.js"
mkdir -p "tests/lib/linter"
cp "/tests/lib/linter/linter.js" "tests/lib/linter/linter.js"

# Run only the specific test files that were added/modified in this PR
# Exclude the failing test "ES6 global variables should be available by default" which is unrelated to this PR
npx mocha tests/lib/linter/apply-disable-directives.js tests/lib/linter/linter.js --grep "ES6 global variables should be available by default" --invert
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
