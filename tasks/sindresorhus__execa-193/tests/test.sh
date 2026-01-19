#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/errname.js" "test/errname.js"
mkdir -p "test"
cp "/tests/stdio.js" "test/stdio.js"

# Run the specific test files for this PR using AVA
npx ava --timeout=60s test/errname.js test/stdio.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
