#!/bin/bash

cd /app/src

# Rebuild to reflect any changes from agent (e.g., Oracle applying fix.patch)
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/unit-tests/function/matrix"
cp "/tests/unit-tests/function/matrix/map.test.js" "test/unit-tests/function/matrix/map.test.js"

# Run JavaScript tests with mocha
npx mocha test/unit-tests/function/matrix/map.test.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
