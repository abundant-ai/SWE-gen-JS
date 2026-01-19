#!/bin/bash

cd /app/src

# Rebuild to reflect any changes from agent (e.g., Oracle applying fix.patch)
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/node-tests/plain/number"
cp "/tests/node-tests/plain/number/arithmetic.test.js" "test/node-tests/plain/number/arithmetic.test.js"
mkdir -p "test/unit-tests/expression"
cp "/tests/unit-tests/expression/parse.test.js" "test/unit-tests/expression/parse.test.js"
mkdir -p "test/unit-tests/function/arithmetic"
cp "/tests/unit-tests/function/arithmetic/mod.test.js" "test/unit-tests/function/arithmetic/mod.test.js"

# Run JavaScript tests with mocha
# Note: For node-tests, must use glob pattern with multiple matches for ES module support to work
npx mocha test/node-tests/*.test.js test/node-tests/**/*.test.js test/unit-tests/expression/parse.test.js test/unit-tests/function/arithmetic/mod.test.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
