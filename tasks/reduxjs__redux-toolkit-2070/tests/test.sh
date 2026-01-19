#!/bin/bash

cd /app/src

# Reinstall dependencies in case package.json was modified by agent
yarn install

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/action-listener-middleware/src/tests"
cp "/tests/packages/action-listener-middleware/src/tests/fork.test.ts" "packages/action-listener-middleware/src/tests/fork.test.ts"
mkdir -p "packages/action-listener-middleware/src/tests"
cp "/tests/packages/action-listener-middleware/src/tests/listenerMiddleware.test.ts" "packages/action-listener-middleware/src/tests/listenerMiddleware.test.ts"

# Build toolkit package first (peer dependency)
cd packages/toolkit
rm -rf dist/
yarn build

# Clear any build artifacts and rebuild action-listener-middleware with updated code
cd ../action-listener-middleware
rm -rf dist/
yarn build

# Run Jest tests on the specific test files
npx jest --runInBand --coverage=false \
  src/tests/fork.test.ts \
  src/tests/listenerMiddleware.test.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
