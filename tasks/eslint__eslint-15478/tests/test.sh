#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/no-restricted-exports.js" "tests/lib/rules/no-restricted-exports.js"

# Run only the specific test files that were added/modified in this PR
npx mocha tests/lib/rules/no-restricted-exports.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
