#!/bin/bash

cd /app/src

# No additional environment variables needed

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/rehydration.test.ts" "packages/core/test/rehydration.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/system.test.ts" "packages/core/test/system.test.ts"

# Run vitest on the specific test files
pnpm exec vitest run packages/core/test/rehydration.test.ts packages/core/test/system.test.ts --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
