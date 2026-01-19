#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/promap.js" "test/promap.js"
mkdir -p "test/shared"
cp "/tests/shared/Pair.js" "test/shared/Pair.js"

# Run Mocha on the specific test files with Babel register and BABEL_ENV=cjs
BABEL_ENV=cjs npx mocha --require @babel/register --reporter spec test/promap.js test/shared/Pair.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
