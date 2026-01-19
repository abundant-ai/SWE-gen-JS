#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/permessage-deflate.test.js" "test/permessage-deflate.test.js"

# Run ONLY the specific test files using Mocha
npx mocha --throw-deprecation test/permessage-deflate.test.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
