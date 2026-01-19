#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/unit-tests/expression/function"
cp "/tests/unit-tests/expression/function/evaluate.test.js" "test/unit-tests/expression/function/evaluate.test.js"
mkdir -p "test/unit-tests/expression"
cp "/tests/unit-tests/expression/operators.test.js" "test/unit-tests/expression/operators.test.js"
mkdir -p "test/unit-tests/function/logical"
cp "/tests/unit-tests/function/logical/nullish.test.js" "test/unit-tests/function/logical/nullish.test.js"

# Run the specific test files using Mocha
npx mocha test/unit-tests/expression/function/evaluate.test.js test/unit-tests/expression/operators.test.js test/unit-tests/function/logical/nullish.test.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
