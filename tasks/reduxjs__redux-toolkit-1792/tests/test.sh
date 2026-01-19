#!/bin/bash

cd /app/src

# Reinstall dependencies in case package.json was modified by agent
yarn install

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/action-listener-middleware/src/tests"
cp "/tests/packages/action-listener-middleware/src/tests/effectScenarios.test.ts" "packages/action-listener-middleware/src/tests/effectScenarios.test.ts"
mkdir -p "packages/action-listener-middleware/src/tests"
cp "/tests/packages/action-listener-middleware/src/tests/listenerMiddleware.test.ts" "packages/action-listener-middleware/src/tests/listenerMiddleware.test.ts"

# Run Jest tests on the specific test files from this PR (from action-listener-middleware package directory)
cd packages/action-listener-middleware
yarn jest src/tests/effectScenarios.test.ts src/tests/listenerMiddleware.test.ts --coverage=false --globals='{"ts-jest":{"diagnostics":false}}'
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
