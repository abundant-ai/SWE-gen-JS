#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "types/test"
cp "/tests/types/test/461.ts" "types/test/461.ts"

# Run TypeScript type checking on the specific test file
npx tsc --strict --noEmit types/test/461.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
