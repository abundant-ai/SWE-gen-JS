#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/sequence.js" "test/sequence.js"
mkdir -p "test"
cp "/tests/traverse.js" "test/traverse.js"

# Run Mocha on the specific test files with Babel register
npx mocha --require @babel/register --reporter spec test/sequence.js test/traverse.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
