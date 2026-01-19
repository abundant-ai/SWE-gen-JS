#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/lib/cli-engine"
cp "/tests/lib/cli-engine/cli-engine.js" "tests/lib/cli-engine/cli-engine.js"
mkdir -p "tests/lib/cli-engine"
cp "/tests/lib/cli-engine/lint-result-cache.js" "tests/lib/cli-engine/lint-result-cache.js"
mkdir -p "tests/lib/eslint"
cp "/tests/lib/eslint/eslint.js" "tests/lib/eslint/eslint.js"

# Run specific test files using mocha with increased timeout
npx mocha --timeout 10000 \
  tests/lib/cli-engine/cli-engine.js \
  tests/lib/cli-engine/lint-result-cache.js \
  tests/lib/eslint/eslint.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
