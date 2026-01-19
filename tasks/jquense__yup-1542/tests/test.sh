#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/array.ts" "test/array.ts"
mkdir -p "test"
cp "/tests/mixed.ts" "test/mixed.ts"
mkdir -p "test"
cp "/tests/object.ts" "test/object.ts"
mkdir -p "test/types"
cp "/tests/types/types.ts" "test/types/types.ts"
mkdir -p "test"
cp "/tests/yup.js" "test/yup.js"

# Run Jest on specific test files (disable coverage to run subset)
npx jest test/array.ts test/mixed.ts test/object.ts test/types/types.ts test/yup.js --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
