#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/path.js" "test/path.js"

# Run Mocha on the specific test files with Babel 6 register and BABEL_ENV=cjs
BABEL_ENV=cjs npx mocha --require babel-register --reporter spec test/path.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
