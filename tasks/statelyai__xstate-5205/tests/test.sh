#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/xstate-store/test"
cp "/tests/packages/xstate-store/test/react.test.tsx" "packages/xstate-store/test/react.test.tsx"
mkdir -p "packages/xstate-store/test"
cp "/tests/packages/xstate-store/test/store.test.ts" "packages/xstate-store/test/store.test.ts"

# Run jest on the specific test files
pnpm exec jest packages/xstate-store/test/react.test.tsx packages/xstate-store/test/store.test.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
