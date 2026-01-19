#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/middleware/test"
cp "/tests/packages/middleware/test/security.spec.ts" "packages/middleware/test/security.spec.ts"

# Run the specific test file with vitest (disable coverage for subset)
# Path is relative to the package directory when using --filter
pnpm --filter @verdaccio/middleware test test/security.spec.ts --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
