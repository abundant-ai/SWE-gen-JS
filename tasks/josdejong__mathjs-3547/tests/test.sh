#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/benchmark"
cp "/tests/benchmark/accessor.js" "test/benchmark/accessor.js"
mkdir -p "test/unit-tests/expression/node"
cp "/tests/unit-tests/expression/node/AccessorNode.test.js" "test/unit-tests/expression/node/AccessorNode.test.js"
mkdir -p "test/unit-tests/expression"
cp "/tests/unit-tests/expression/parse.test.js" "test/unit-tests/expression/parse.test.js"

# Run the specific test files using Mocha
npx mocha test/benchmark/accessor.js test/unit-tests/expression/node/AccessorNode.test.js test/unit-tests/expression/parse.test.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
