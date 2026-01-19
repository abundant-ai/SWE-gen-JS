#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/lib/config"
cp "/tests/lib/config/flat-config-array.js" "tests/lib/config/flat-config-array.js"

# Run the specific test file using mocha
npx mocha tests/lib/config/flat-config-array.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
