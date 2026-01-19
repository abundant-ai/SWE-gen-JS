#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "ohm-js/test"
cp "/tests/ohm-js/test/test-ohm-syntax.js" "ohm-js/test/test-ohm-syntax.js"
mkdir -p "ohm-js/test"
cp "/tests/ohm-js/test/test-recipes.js" "ohm-js/test/test-recipes.js"

# Run the specific test files from the PR using tape
cd ohm-js
npx tape test/test-ohm-syntax.js test/test-recipes.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
