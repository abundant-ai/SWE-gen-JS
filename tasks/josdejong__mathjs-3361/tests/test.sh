#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/unit-tests/expression/node"
cp "/tests/unit-tests/expression/node/IndexNode.test.js" "test/unit-tests/expression/node/IndexNode.test.js"
mkdir -p "test/unit-tests/expression"
cp "/tests/unit-tests/expression/parse.test.js" "test/unit-tests/expression/parse.test.js"
mkdir -p "test/unit-tests/function/matrix"
cp "/tests/unit-tests/function/matrix/range.test.js" "test/unit-tests/function/matrix/range.test.js"
mkdir -p "test/unit-tests/type/matrix"
cp "/tests/unit-tests/type/matrix/Index.test.js" "test/unit-tests/type/matrix/Index.test.js"
mkdir -p "test/unit-tests/type/matrix/function"
cp "/tests/unit-tests/type/matrix/function/index.test.js" "test/unit-tests/type/matrix/function/index.test.js"

# Run the specific test files using mocha
npx mocha test/unit-tests/expression/node/IndexNode.test.js test/unit-tests/expression/parse.test.js test/unit-tests/function/matrix/range.test.js test/unit-tests/type/matrix/Index.test.js test/unit-tests/type/matrix/function/index.test.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
