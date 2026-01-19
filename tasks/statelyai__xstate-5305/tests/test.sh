#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/xstate-store/test"
cp "/tests/packages/xstate-store/test/store.test.ts" "packages/xstate-store/test/store.test.ts"
mkdir -p "packages/xstate-store/test"
cp "/tests/packages/xstate-store/test/undo.test.ts" "packages/xstate-store/test/undo.test.ts"

# Run vitest on the specific test files
pnpm exec vitest run packages/xstate-store/test/store.test.ts packages/xstate-store/test/undo.test.ts --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
