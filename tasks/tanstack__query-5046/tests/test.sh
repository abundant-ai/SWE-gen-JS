#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/codemods/src/v5/remove-overloads/__tests__"
cp "/tests/packages/codemods/src/v5/remove-overloads/__tests__/remove-overloads.test.js" "packages/codemods/src/v5/remove-overloads/__tests__/remove-overloads.test.js"

# Run the specific test file with jest (disable coverage)
cd /app/src/packages/codemods
NODE_OPTIONS="--max-old-space-size=2048" npx jest src/v5/remove-overloads/__tests__/remove-overloads.test.js --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
