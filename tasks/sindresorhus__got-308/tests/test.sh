#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/arguments.js" "test/arguments.js"
cp "/tests/error.js" "test/error.js"
cp "/tests/gzip.js" "test/gzip.js"
cp "/tests/helpers.js" "test/helpers.js"
cp "/tests/http.js" "test/http.js"
cp "/tests/json-parse.js" "test/json-parse.js"
cp "/tests/redirects.js" "test/redirects.js"
cp "/tests/retry.js" "test/retry.js"
cp "/tests/timeout.js" "test/timeout.js"

# Run only the specific test files for this PR using AVA
npx ava test/arguments.js test/error.js test/gzip.js test/helpers.js test/http.js test/json-parse.js test/redirects.js test/retry.js test/timeout.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
