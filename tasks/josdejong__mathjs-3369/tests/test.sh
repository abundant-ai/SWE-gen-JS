#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/unit-tests/function/arithmetic"
cp "/tests/unit-tests/function/arithmetic/ceil.test.js" "test/unit-tests/function/arithmetic/ceil.test.js"
mkdir -p "test/unit-tests/function/arithmetic"
cp "/tests/unit-tests/function/arithmetic/fix.test.js" "test/unit-tests/function/arithmetic/fix.test.js"
mkdir -p "test/unit-tests/function/arithmetic"
cp "/tests/unit-tests/function/arithmetic/floor.test.js" "test/unit-tests/function/arithmetic/floor.test.js"
mkdir -p "test/unit-tests/function/arithmetic"
cp "/tests/unit-tests/function/arithmetic/round.test.js" "test/unit-tests/function/arithmetic/round.test.js"

# Run the specific test files using mocha
npx mocha test/unit-tests/function/arithmetic/ceil.test.js test/unit-tests/function/arithmetic/fix.test.js test/unit-tests/function/arithmetic/floor.test.js test/unit-tests/function/arithmetic/round.test.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
