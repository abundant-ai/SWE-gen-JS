#!/bin/bash

cd /app/src

# Reinstall dependencies in case fix.patch changed package files
npm ci

# Rebuild TypeScript project with the fix applied
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/client.test.ts" "test/client.test.ts"

# Run Jest test for the specific file with coverage disabled
npx jest test/client.test.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
