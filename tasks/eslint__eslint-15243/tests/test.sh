#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/fixtures/formatters"
cp "/tests/fixtures/formatters/async.js" "tests/fixtures/formatters/async.js"
mkdir -p "tests/lib/cli-engine"
cp "/tests/lib/cli-engine/cli-engine.js" "tests/lib/cli-engine/cli-engine.js"
mkdir -p "tests/lib"
cp "/tests/lib/cli.js" "tests/lib/cli.js"
mkdir -p "tests/lib/eslint"
cp "/tests/lib/eslint/eslint.js" "tests/lib/eslint/eslint.js"

# Run only the specific test files that were added/modified in this PR
npx mocha tests/fixtures/formatters/async.js tests/lib/cli-engine/cli-engine.js tests/lib/cli.js tests/lib/eslint/eslint.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
