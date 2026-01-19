#!/bin/bash

cd /app/src

# Reinstall dependencies in case fix.patch changed package files
npm ci

# Rebuild TypeScript project with the fix applied
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/SupabaseAuthClient.test.ts" "test/SupabaseAuthClient.test.ts"
mkdir -p "test"
cp "/tests/client.test.ts" "test/client.test.ts"
mkdir -p "test"
cp "/tests/helpers.test.ts" "test/helpers.test.ts"

# Run Jest test for the specific files with coverage disabled
npx jest test/SupabaseAuthClient.test.ts test/client.test.ts test/helpers.test.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
