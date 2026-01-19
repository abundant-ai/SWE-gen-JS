#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/ascendNatural.js" "test/ascendNatural.js"
mkdir -p "test"
cp "/tests/descendNatural.js" "test/descendNatural.js"

# Run Mocha on the specific test files with Babel register
npx mocha --require @babel/register --reporter spec test/ascendNatural.js test/descendNatural.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
