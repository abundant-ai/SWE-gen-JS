#!/bin/bash

cd /app/src

# Run Mocha on the specific test files with Babel register
npx mocha --require @babel/register --reporter spec test/isNotNil.js test/swap.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
