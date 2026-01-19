#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/unit-tests/function/matrix"
cp "/tests/unit-tests/function/matrix/range.test.js" "test/unit-tests/function/matrix/range.test.js"
mkdir -p "test/unit-tests/type/matrix"
cp "/tests/unit-tests/type/matrix/Index.test.js" "test/unit-tests/type/matrix/Index.test.js"
cp "/tests/unit-tests/type/matrix/Range.test.js" "test/unit-tests/type/matrix/Range.test.js"

# Run the specific test files using Mocha
npx mocha test/unit-tests/function/matrix/range.test.js test/unit-tests/type/matrix/Index.test.js test/unit-tests/type/matrix/Range.test.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
