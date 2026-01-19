#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/mergeDeepLeft.js" "test/mergeDeepLeft.js"
mkdir -p "test"
cp "/tests/mergeDeepRight.js" "test/mergeDeepRight.js"
mkdir -p "test"
cp "/tests/mergeDeepWith.js" "test/mergeDeepWith.js"
mkdir -p "test"
cp "/tests/mergeDeepWithKey.js" "test/mergeDeepWithKey.js"

# Run Mocha on the specific test files
npx mocha --reporter spec test/mergeDeepLeft.js test/mergeDeepRight.js test/mergeDeepWith.js test/mergeDeepWithKey.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
