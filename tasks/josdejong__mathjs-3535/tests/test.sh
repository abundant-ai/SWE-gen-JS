#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/unit-tests/expression"
cp "/tests/unit-tests/expression/parse.test.js" "test/unit-tests/expression/parse.test.js"
mkdir -p "test/unit-tests/function/algebra"
cp "/tests/unit-tests/function/algebra/simplify.test.js" "test/unit-tests/function/algebra/simplify.test.js"
mkdir -p "test/unit-tests/function/matrix"
cp "/tests/unit-tests/function/matrix/eigs.test.js" "test/unit-tests/function/matrix/eigs.test.js"
mkdir -p "test/unit-tests/function/matrix"
cp "/tests/unit-tests/function/matrix/ones.test.js" "test/unit-tests/function/matrix/ones.test.js"
mkdir -p "test/unit-tests/function/matrix"
cp "/tests/unit-tests/function/matrix/size.test.js" "test/unit-tests/function/matrix/size.test.js"
mkdir -p "test/unit-tests/function/matrix"
cp "/tests/unit-tests/function/matrix/squeeze.test.js" "test/unit-tests/function/matrix/squeeze.test.js"
mkdir -p "test/unit-tests/function/matrix"
cp "/tests/unit-tests/function/matrix/zeros.test.js" "test/unit-tests/function/matrix/zeros.test.js"
mkdir -p "test/unit-tests/type/chain"
cp "/tests/unit-tests/type/chain/Chain.test.js" "test/unit-tests/type/chain/Chain.test.js"
mkdir -p "test/unit-tests/type/matrix/function"
cp "/tests/unit-tests/type/matrix/function/matrix.test.js" "test/unit-tests/type/matrix/function/matrix.test.js"

# Run the specific test files using Mocha
npx mocha test/unit-tests/expression/parse.test.js test/unit-tests/function/algebra/simplify.test.js test/unit-tests/function/matrix/eigs.test.js test/unit-tests/function/matrix/ones.test.js test/unit-tests/function/matrix/size.test.js test/unit-tests/function/matrix/squeeze.test.js test/unit-tests/function/matrix/zeros.test.js test/unit-tests/type/chain/Chain.test.js test/unit-tests/type/matrix/function/matrix.test.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
