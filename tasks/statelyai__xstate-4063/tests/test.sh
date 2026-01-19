#!/bin/bash

cd /app/src

# Clear Jest cache to ensure fresh test run
npx jest --clearCache 2>/dev/null || true

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/meta.test.ts" "packages/core/test/meta.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/state.test.ts" "packages/core/test/state.test.ts"
mkdir -p "packages/xstate-inspect/test"
cp "/tests/packages/xstate-inspect/test/inspect.test.ts" "packages/xstate-inspect/test/inspect.test.ts"
mkdir -p "packages/xstate-solid/test"
cp "/tests/packages/xstate-solid/test/useMachine.test.tsx" "packages/xstate-solid/test/useMachine.test.tsx"

# Run Jest on the specific test files for this PR
npx jest packages/core/test/meta.test.ts packages/core/test/state.test.ts packages/xstate-inspect/test/inspect.test.ts packages/xstate-solid/test/useMachine.test.tsx --coverage=false --runInBand --no-cache
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
