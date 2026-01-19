#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/stdio"
cp "/tests/stdio/array.js" "test/stdio/array.js"
cp "/tests/stdio/file-path.js" "test/stdio/file-path.js"

# Run the specific test files using AVA
npx ava test/stdio/array.js test/stdio/file-path.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
