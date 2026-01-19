#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/configureStore.test.ts" "packages/toolkit/src/tests/configureStore.test.ts"
cp "/tests/packages/toolkit/src/tests/configureStore.typetest.ts" "packages/toolkit/src/tests/configureStore.typetest.ts"
cp "/tests/packages/toolkit/src/tests/getDefaultMiddleware.test.ts" "packages/toolkit/src/tests/getDefaultMiddleware.test.ts"
cp "/tests/packages/toolkit/src/tests/serializableStateInvariantMiddleware.test.ts" "packages/toolkit/src/tests/serializableStateInvariantMiddleware.test.ts"

# Run specific test files with vitest
cd packages/toolkit

# Run the configureStore tests but only match specific test names that test the middleware behavior
# - "throws an error requiring a callback" - tests that array middleware throws
# - Tests that don't rely on mockDevtoolsCompose
npx vitest run src/tests/configureStore.test.ts \
  --testNamePattern="throws an error|returns undefined|throws|middleware builder notation" \
  --no-coverage
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
