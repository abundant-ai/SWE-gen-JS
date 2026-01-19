#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/date.ts" "test/date.ts"
mkdir -p "test"
cp "/tests/number.ts" "test/number.ts"
mkdir -p "test"
cp "/tests/object.ts" "test/object.ts"

# Run the specific test files with Jest
yarn testonly test/date.ts test/number.ts test/object.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
