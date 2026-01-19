#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/assoc.js" "test/assoc.js"
mkdir -p "test"
cp "/tests/dissoc.js" "test/dissoc.js"
mkdir -p "test"
cp "/tests/dissocPath.js" "test/dissocPath.js"

# Run Mocha on the specific test files with Babel register and BABEL_ENV=cjs
BABEL_ENV=cjs npx mocha --require @babel/register --reporter spec test/assoc.js test/dissoc.js test/dissocPath.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
