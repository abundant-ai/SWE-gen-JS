#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/memoize.js" "test/memoize.js"
mkdir -p "test"
cp "/tests/memoizeWith.js" "test/memoizeWith.js"

# Run Mocha on the specific test files
npx mocha --reporter spec test/memoize.js test/memoizeWith.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
