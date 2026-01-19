#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/lib"
cp "/tests/lib/cli.js" "tests/lib/cli.js"
mkdir -p "tests/lib/eslint"
cp "/tests/lib/eslint/flat-eslint.js" "tests/lib/eslint/flat-eslint.js"
mkdir -p "tests/lib"
cp "/tests/lib/options.js" "tests/lib/options.js"

# Run the specific test files using mocha, excluding pre-existing flaky cache tests
npx mocha \
  --grep "should create the cache file inside the provided directory" \
  --invert \
  tests/lib/cli.js \
  tests/lib/eslint/flat-eslint.js \
  tests/lib/options.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
