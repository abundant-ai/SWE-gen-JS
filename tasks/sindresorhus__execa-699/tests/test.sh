#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/fixtures"
cp "/tests/fixtures/nested-inherit.js" "test/fixtures/nested-inherit.js"
mkdir -p "test/stdio"
cp "/tests/stdio/encoding.js" "test/stdio/encoding.js"
cp "/tests/stdio/generator.js" "test/stdio/generator.js"
cp "/tests/stdio/lines.js" "test/stdio/lines.js"

# Run only the specific test files using AVA
npx ava test/stdio/encoding.js test/stdio/generator.js test/stdio/lines.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
