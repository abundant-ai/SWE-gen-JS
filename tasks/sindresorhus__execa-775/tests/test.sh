#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/stdio"
cp "/tests/stdio/file-path.js" "test/stdio/file-path.js"
cp "/tests/stdio/iterable.js" "test/stdio/iterable.js"
cp "/tests/stdio/node-stream.js" "test/stdio/node-stream.js"
cp "/tests/stdio/web-stream.js" "test/stdio/web-stream.js"

# Run only the specific test files using AVA
npx ava test/stdio/file-path.js test/stdio/iterable.js test/stdio/node-stream.js test/stdio/web-stream.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
