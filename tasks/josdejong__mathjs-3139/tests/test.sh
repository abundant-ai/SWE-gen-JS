#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/unit-tests/function/matrix"
cp "/tests/unit-tests/function/matrix/det.test.js" "test/unit-tests/function/matrix/det.test.js"
mkdir -p "test/unit-tests/function/utils"
cp "/tests/unit-tests/function/utils/isNegative.test.js" "test/unit-tests/function/utils/isNegative.test.js"
mkdir -p "test/unit-tests/function/utils"
cp "/tests/unit-tests/function/utils/isPositive.test.js" "test/unit-tests/function/utils/isPositive.test.js"
mkdir -p "test/unit-tests/function/utils"
cp "/tests/unit-tests/function/utils/isZero.test.js" "test/unit-tests/function/utils/isZero.test.js"

# Run JavaScript unit tests with mocha
npx mocha test/unit-tests/function/matrix/det.test.js test/unit-tests/function/utils/isNegative.test.js test/unit-tests/function/utils/isPositive.test.js test/unit-tests/function/utils/isZero.test.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
