#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/helpers"
cp "/tests/helpers/generator.js" "test/helpers/generator.js"
mkdir -p "test/stdio"
cp "/tests/stdio/generator.js" "test/stdio/generator.js"
cp "/tests/stdio/node-stream.js" "test/stdio/node-stream.js"

# Run only the specific test files using AVA (excluding helper files which have no tests)
npx ava test/stdio/generator.js test/stdio/node-stream.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
