#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/test.js" "test/test.js"

# Run only the preferLocal-related tests (the ones modified by this PR)
npx ava --timeout=60s --match="*preferLocal*" --match="*localDir*" test/test.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
