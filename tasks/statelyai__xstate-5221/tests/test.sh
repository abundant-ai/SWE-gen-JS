#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/xstate-store/test"
cp "/tests/packages/xstate-store/test/atom.test.ts" "packages/xstate-store/test/atom.test.ts"
mkdir -p "packages/xstate-store/test"
cp "/tests/packages/xstate-store/test/react.test.tsx" "packages/xstate-store/test/react.test.tsx"

# Run jest on the specific test files
pnpm exec jest packages/xstate-store/test/atom.test.ts packages/xstate-store/test/react.test.tsx --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
