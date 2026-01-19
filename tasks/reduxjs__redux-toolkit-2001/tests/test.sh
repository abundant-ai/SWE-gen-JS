#!/bin/bash

cd /app/src

# Reinstall dependencies in case package.json was modified by agent
yarn install

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/action-listener-middleware/src/tests"
cp "/tests/packages/action-listener-middleware/src/tests/fork.test.ts" "packages/action-listener-middleware/src/tests/fork.test.ts"
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/MiddlewareArray.typetest.ts" "packages/toolkit/src/tests/MiddlewareArray.typetest.ts"
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/configureStore.typetest.ts" "packages/toolkit/src/tests/configureStore.typetest.ts"
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/getDefaultMiddleware.test.ts" "packages/toolkit/src/tests/getDefaultMiddleware.test.ts"

# Build toolkit package first (peer dependency)
cd packages/toolkit
rm -rf dist/
yarn build

# Clear any build artifacts and rebuild action-listener-middleware with updated code
cd ../action-listener-middleware
rm -rf dist/
yarn build

# Run Jest tests on the specific test files for fork.test.ts
npx jest --runInBand --coverage=false \
  src/tests/fork.test.ts
test_status=$?

# If first test passed, run the toolkit tests
if [ $test_status -eq 0 ]; then
  cd ../toolkit
  npx jest --runInBand --coverage=false \
    src/tests/MiddlewareArray.typetest.ts \
    src/tests/configureStore.typetest.ts \
    src/tests/getDefaultMiddleware.test.ts
  test_status=$?
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
