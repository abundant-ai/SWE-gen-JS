#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/dat"
cp "/tests/dat/Hello.avdl" "test/dat/Hello.avdl"
mkdir -p "test"
cp "/tests/test_specs.js" "test/test_specs.js"

# Run mocha on the specific test file
npx mocha test/test_specs.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
