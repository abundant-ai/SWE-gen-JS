#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/encoding.js" "test/encoding.js"
cp "/tests/error.js" "test/error.js"
cp "/tests/kill.js" "test/kill.js"
cp "/tests/node.js" "test/node.js"
cp "/tests/pipe.js" "test/pipe.js"
mkdir -p "test/fixtures"
cp "/tests/fixtures/echo-fail.js" "test/fixtures/echo-fail.js"
cp "/tests/fixtures/max-buffer.js" "test/fixtures/max-buffer.js"
cp "/tests/fixtures/nested-multiple-stderr.js" "test/fixtures/nested-multiple-stderr.js"
cp "/tests/fixtures/nested-stdio.js" "test/fixtures/nested-stdio.js"
cp "/tests/fixtures/noop-delay.js" "test/fixtures/noop-delay.js"
cp "/tests/fixtures/noop-fail.js" "test/fixtures/noop-fail.js"
cp "/tests/fixtures/noop-fd.js" "test/fixtures/noop-fd.js"
cp "/tests/fixtures/stdin-fd.js" "test/fixtures/stdin-fd.js"
mkdir -p "test/helpers"
cp "/tests/helpers/run.js" "test/helpers/run.js"
cp "/tests/helpers/stdio.js" "test/helpers/stdio.js"
mkdir -p "test/stdio"
cp "/tests/stdio/array.js" "test/stdio/array.js"
cp "/tests/stdio/file-descriptor.js" "test/stdio/file-descriptor.js"

# Ensure fixture files are executable (they are scripts called by tests)
chmod +x test/fixtures/*.js

# Run the specific test files using AVA
npx ava test/encoding.js test/error.js test/node.js test/pipe.js test/stdio/array.js test/stdio/file-descriptor.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
