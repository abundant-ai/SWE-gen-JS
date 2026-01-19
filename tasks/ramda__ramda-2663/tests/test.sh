#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/reduceBy.js" "test/reduceBy.js"
mkdir -p "test"
cp "/tests/reduceRight.js" "test/reduceRight.js"

# Run Mocha on the specific test files with Babel 7 register and BABEL_ENV=cjs
BABEL_ENV=cjs npx mocha --require @babel/register --reporter spec test/reduceBy.js test/reduceRight.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
