#!/bin/bash

cd /app/src

# Clear Jest cache to ensure fresh test run
npx jest --clearCache 2>/dev/null || true

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/actions.test.ts" "packages/core/test/actions.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/activities.test.ts" "packages/core/test/activities.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/history.test.ts" "packages/core/test/history.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/internalTransitions.test.ts" "packages/core/test/internalTransitions.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/invoke.test.ts" "packages/core/test/invoke.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/json.test.ts" "packages/core/test/json.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/parallel.test.ts" "packages/core/test/parallel.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/predictableExec.test.ts" "packages/core/test/predictableExec.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/scxml.test.ts" "packages/core/test/scxml.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/state.test.ts" "packages/core/test/state.test.ts"
mkdir -p "packages/xstate-inspect/test"
cp "/tests/packages/xstate-inspect/test/inspect.test.ts" "packages/xstate-inspect/test/inspect.test.ts"
mkdir -p "packages/xstate-scxml/test/fixtures/actionSend"
cp "/tests/packages/xstate-scxml/test/fixtures/actionSend/send1.ts" "packages/xstate-scxml/test/fixtures/actionSend/send1.ts"

# Rebuild after copying test files to ensure they can import from updated built files
yarn build

# Set up dev symlinks to ensure packages can find each other
npx preconstruct dev

# Run Jest on only the specific test files for this PR
yarn jest \
  packages/core/test/actions.test.ts \
  packages/core/test/activities.test.ts \
  packages/core/test/history.test.ts \
  packages/core/test/internalTransitions.test.ts \
  packages/core/test/invoke.test.ts \
  packages/core/test/json.test.ts \
  packages/core/test/parallel.test.ts \
  packages/core/test/predictableExec.test.ts \
  packages/core/test/scxml.test.ts \
  packages/core/test/state.test.ts \
  packages/xstate-inspect/test/inspect.test.ts \
  packages/xstate-scxml/test/fixtures/actionSend/send1.ts \
  --coverage=false --runInBand --no-cache
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
