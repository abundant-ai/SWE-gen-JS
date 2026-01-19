#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/lib/linter/code-path-analysis"
cp "/tests/lib/linter/code-path-analysis/code-path-analyzer.js" "tests/lib/linter/code-path-analysis/code-path-analyzer.js"
mkdir -p "tests/lib/rule-tester"
cp "/tests/lib/rule-tester/rule-tester.js" "tests/lib/rule-tester/rule-tester.js"

# Run the specific test files using mocha
npx mocha tests/lib/linter/code-path-analysis/code-path-analyzer.js tests/lib/rule-tester/rule-tester.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
