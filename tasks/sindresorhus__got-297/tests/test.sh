#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/arguments.js" "test/arguments.js"
mkdir -p "test"
cp "/tests/headers.js" "test/headers.js"
mkdir -p "test"
cp "/tests/json-parse.js" "test/json-parse.js"
mkdir -p "test"
cp "/tests/post.js" "test/post.js"

# Run only the specific test files for this PR using AVA
npx ava test/arguments.js test/headers.js test/json-parse.js test/post.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
