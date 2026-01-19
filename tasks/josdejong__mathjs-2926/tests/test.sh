#!/bin/bash

cd /app/src

# Rebuild to reflect any changes from agent (e.g., Oracle applying fix.patch)
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/unit-tests/type/bignumber/function"
cp "/tests/unit-tests/type/bignumber/function/bignumber.test.js" "test/unit-tests/type/bignumber/function/bignumber.test.js"
mkdir -p "test/unit-tests/type/fraction/function"
cp "/tests/unit-tests/type/fraction/function/fraction.test.js" "test/unit-tests/type/fraction/function/fraction.test.js"
mkdir -p "test/unit-tests/type"
cp "/tests/unit-tests/type/number.test.js" "test/unit-tests/type/number.test.js"

# Run JavaScript tests with mocha
npx mocha test/unit-tests/type/bignumber/function/bignumber.test.js test/unit-tests/type/fraction/function/fraction.test.js test/unit-tests/type/number.test.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
