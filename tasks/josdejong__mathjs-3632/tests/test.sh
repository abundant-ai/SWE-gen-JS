#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/unit-tests/function/relational"
cp "/tests/unit-tests/function/relational/compareNatural.test.js" "test/unit-tests/function/relational/compareNatural.test.js"

# Run the specific test file using Mocha
npx mocha test/unit-tests/function/relational/compareNatural.test.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
