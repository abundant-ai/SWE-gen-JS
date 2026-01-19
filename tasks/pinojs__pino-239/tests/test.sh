#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/http.test.js" "test/http.test.js"
mkdir -p "test"
cp "/tests/timestamp.test.js" "test/timestamp.test.js"

# Run only the specific test files using tap (with no coverage check for subset runs)
npx tap test/http.test.js test/timestamp.test.js --no-cov
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
