#!/bin/bash

cd /app/src

# Set environment variable for CI
export CI=true

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/fixtures/custom"
cp "/tests/fixtures/custom/reason-invalid.js" "test/fixtures/custom/reason-invalid.js"
mkdir -p "test"
cp "/tests/index.js" "test/index.js"

# Run tests using mocha (test/index.js is the main test file that loads fixtures)
npx mocha --require babel-core/register ./test/index.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
