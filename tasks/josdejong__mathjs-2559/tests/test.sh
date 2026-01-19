#!/bin/bash

cd /app/src

# Rebuild to reflect any changes from agent (e.g., Oracle applying fix.patch)
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/unit-tests/type/chain"
cp "/tests/unit-tests/type/chain/Chain.test.js" "test/unit-tests/type/chain/Chain.test.js"

# Run JavaScript tests with mocha
npx mocha test/unit-tests/type/chain/Chain.test.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
