#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/EnhancerArray.typetest.ts" "packages/toolkit/src/tests/EnhancerArray.typetest.ts"
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/configureStore.test.ts" "packages/toolkit/src/tests/configureStore.test.ts"
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/configureStore.typetest.ts" "packages/toolkit/src/tests/configureStore.typetest.ts"

# Run the regular Jest tests first
cd packages/toolkit
yarn test src/tests/configureStore.test.ts
test_status=$?

# Only run type tests if regular tests passed
if [ $test_status -eq 0 ]; then
  # Run TypeScript type checks using the proper tsconfig
  # This will check all typetest files in the project, including our updated ones
  npx tsc -p src/tests/tsconfig.typetests.json --noEmit
  test_status=$?
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
