#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/integration/__tests__/__snapshots__"
cp "/tests/integration/__tests__/__snapshots__/infer-parser.js.snap" "tests/integration/__tests__/__snapshots__/infer-parser.js.snap"
mkdir -p "tests/integration/__tests__"
cp "/tests/integration/__tests__/infer-parser.js" "tests/integration/__tests__/infer-parser.js"
mkdir -p "tests/integration/cli/infer-parser/.husky"
cp "/tests/integration/cli/infer-parser/.husky/pre-commit" "tests/integration/cli/infer-parser/.husky/pre-commit"
mkdir -p "tests/integration/plugins/languages"
cp "/tests/integration/plugins/languages/is-supported.js" "tests/integration/plugins/languages/is-supported.js"

# Run the specific tests for this PR
# Test files: tests/integration/__tests__/infer-parser.js and tests/integration/plugins/languages/is-supported.js
npx jest tests/integration/__tests__/infer-parser.js tests/integration/plugins/languages/is-supported.js --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
