#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/fixtures"
cp "/tests/fixtures/all-fail.js" "test/fixtures/all-fail.js"
cp "/tests/fixtures/all.js" "test/fixtures/all.js"
cp "/tests/fixtures/nested-inherit.js" "test/fixtures/nested-inherit.js"
cp "/tests/fixtures/noop-fail.js" "test/fixtures/noop-fail.js"
mkdir -p "test/stdio"
cp "/tests/stdio/generator.js" "test/stdio/generator.js"

# Ensure fixture files are executable (they are scripts called by tests)
chmod +x test/fixtures/*.js

# Run only the specific test file using AVA
npx ava test/stdio/generator.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
