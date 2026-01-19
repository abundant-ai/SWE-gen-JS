#!/bin/bash

cd /app/src

# Reinstall dependencies in case fix.patch changed package files
npm ci

# Rebuild TypeScript project with the fix applied
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test"
cp "/tests/index.test-d.ts" "test/index.test-d.ts"

# Run type definition test using tsd for the specific file
npx tsd --files test/index.test-d.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
