#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/xstate-store/test"
cp "/tests/packages/xstate-store/test/react.test.tsx" "packages/xstate-store/test/react.test.tsx"

# Run vitest on the specific test file
pnpm exec vitest run packages/xstate-store/test/react.test.tsx --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
