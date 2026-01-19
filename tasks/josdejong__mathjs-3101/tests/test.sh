#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/unit-tests/expression"
cp "/tests/unit-tests/expression/parse.test.js" "test/unit-tests/expression/parse.test.js"

# Run JavaScript unit tests with mocha
npx mocha test/unit-tests/expression/parse.test.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
