#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/unit-tests/expression"
cp "/tests/unit-tests/expression/transforms.test.js" "test/unit-tests/expression/transforms.test.js"
mkdir -p "test/unit-tests/function/matrix"
cp "/tests/unit-tests/function/matrix/filter.test.js" "test/unit-tests/function/matrix/filter.test.js"
mkdir -p "test/unit-tests/function/matrix"
cp "/tests/unit-tests/function/matrix/forEach.test.js" "test/unit-tests/function/matrix/forEach.test.js"
mkdir -p "test/unit-tests/function/matrix"
cp "/tests/unit-tests/function/matrix/map.test.js" "test/unit-tests/function/matrix/map.test.js"

# Run the specific test files using Mocha
npx mocha test/unit-tests/expression/transforms.test.js test/unit-tests/function/matrix/filter.test.js test/unit-tests/function/matrix/forEach.test.js test/unit-tests/function/matrix/map.test.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
