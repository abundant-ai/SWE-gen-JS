#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/internal"
cp "/tests/internal/_isArrayLike.js" "test/internal/_isArrayLike.js"
mkdir -p "test"
cp "/tests/unless.js" "test/unless.js"
mkdir -p "test"
cp "/tests/until.js" "test/until.js"

# Run Mocha on the specific test files
npx mocha --reporter spec test/internal/_isArrayLike.js test/unless.js test/until.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
