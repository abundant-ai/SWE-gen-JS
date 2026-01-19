#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/modify.js" "test/modify.js"
mkdir -p "test"
cp "/tests/modifyPath.js" "test/modifyPath.js"

# Run Mocha on the specific test files with Babel register
npx mocha --require @babel/register --reporter spec test/modify.js test/modifyPath.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
