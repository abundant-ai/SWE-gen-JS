#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/lib/linter/code-path-analysis"
cp "/tests/lib/linter/code-path-analysis/code-path-analyzer.js" "tests/lib/linter/code-path-analysis/code-path-analyzer.js"
mkdir -p "tests/lib/linter"
cp "/tests/lib/linter/linter.js" "tests/lib/linter/linter.js"
mkdir -p "tests/lib/linter"
cp "/tests/lib/linter/node-event-generator.js" "tests/lib/linter/node-event-generator.js"
mkdir -p "tests/lib/rules"
cp "/tests/lib/rules/no-restricted-syntax.js" "tests/lib/rules/no-restricted-syntax.js"

# Run specific test files using mocha with increased timeout
npx mocha --timeout 10000 \
  tests/lib/linter/code-path-analysis/code-path-analyzer.js \
  tests/lib/linter/linter.js \
  tests/lib/linter/node-event-generator.js \
  tests/lib/rules/no-restricted-syntax.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
