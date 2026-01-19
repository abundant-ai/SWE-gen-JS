#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/proxy/test"
cp "/tests/packages/proxy/test/proxy.protocol.spec.ts" "packages/proxy/test/proxy.protocol.spec.ts"

# Run the specific test file with vitest (disable coverage for subset)
# Path is relative to the package directory when using --filter
pnpm --filter @verdaccio/proxy test test/proxy.protocol.spec.ts --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
