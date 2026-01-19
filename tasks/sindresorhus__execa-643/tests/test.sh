#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/fixtures"
cp "/tests/fixtures/empty.js" "test/fixtures/empty.js"
mkdir -p "test/fixtures"
cp "/tests/fixtures/nested-multiple-stderr.js" "test/fixtures/nested-multiple-stderr.js"
mkdir -p "test/fixtures"
cp "/tests/fixtures/nested-multiple-stdin.js" "test/fixtures/nested-multiple-stdin.js"
mkdir -p "test/fixtures"
cp "/tests/fixtures/nested-multiple-stdout.js" "test/fixtures/nested-multiple-stdout.js"
mkdir -p "test/fixtures"
cp "/tests/fixtures/nested-stdio.js" "test/fixtures/nested-stdio.js"
mkdir -p "test/fixtures"
cp "/tests/fixtures/stdin-fd3.js" "test/fixtures/stdin-fd3.js"
mkdir -p "test/stdio"
cp "/tests/stdio/array.js" "test/stdio/array.js"
mkdir -p "test/stdio"
cp "/tests/stdio/node-stream.js" "test/stdio/node-stream.js"

# Make fixture files executable
chmod +x test/fixtures/empty.js
chmod +x test/fixtures/nested-multiple-stderr.js
chmod +x test/fixtures/nested-multiple-stdin.js
chmod +x test/fixtures/nested-multiple-stdout.js
chmod +x test/fixtures/nested-stdio.js
chmod +x test/fixtures/stdin-fd3.js

# Run the specific test files using AVA
npx ava test/stdio/array.js test/stdio/node-stream.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
