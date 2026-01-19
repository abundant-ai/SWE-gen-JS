#!/bin/bash

cd /app/src

# Clear Jest cache to ensure fresh test run
npx jest --clearCache 2>/dev/null || true

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/actions.test.ts" "packages/core/test/actions.test.ts"
cp "/tests/packages/core/test/activities.test.ts" "packages/core/test/activities.test.ts"
cp "/tests/packages/core/test/history.test.ts" "packages/core/test/history.test.ts"
cp "/tests/packages/core/test/internalTransitions.test.ts" "packages/core/test/internalTransitions.test.ts"
cp "/tests/packages/core/test/invoke.test.ts" "packages/core/test/invoke.test.ts"
cp "/tests/packages/core/test/json.test.ts" "packages/core/test/json.test.ts"
cp "/tests/packages/core/test/predictableExec.test.ts" "packages/core/test/predictableExec.test.ts"
cp "/tests/packages/core/test/state.test.ts" "packages/core/test/state.test.ts"

# Rebuild after copying test files to ensure they can import from updated built files
yarn build

# Run Jest on only the specific test files for this PR (core tests only)
# Note: xstate-inspect and xstate-scxml tests excluded due to module resolution issues in test environment
yarn jest \
  packages/core/test/actions.test.ts \
  packages/core/test/activities.test.ts \
  packages/core/test/history.test.ts \
  packages/core/test/internalTransitions.test.ts \
  packages/core/test/invoke.test.ts \
  packages/core/test/json.test.ts \
  packages/core/test/predictableExec.test.ts \
  packages/core/test/state.test.ts \
  --coverage=false --runInBand --no-cache
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
