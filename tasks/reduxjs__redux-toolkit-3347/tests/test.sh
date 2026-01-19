#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/toolkit/src/query/tests"
cp "/tests/packages/toolkit/src/query/tests/cacheCollection.test.ts" "packages/toolkit/src/query/tests/cacheCollection.test.ts"
mkdir -p "packages/toolkit/src/query/tests"
cp "/tests/packages/toolkit/src/query/tests/helpers.tsx" "packages/toolkit/src/query/tests/helpers.tsx"
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/EnhancerArray.typetest.ts" "packages/toolkit/src/tests/EnhancerArray.typetest.ts"
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/MiddlewareArray.typetest.ts" "packages/toolkit/src/tests/MiddlewareArray.typetest.ts"
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/autoBatchEnhancer.test.ts" "packages/toolkit/src/tests/autoBatchEnhancer.test.ts"
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/configureStore.test.ts" "packages/toolkit/src/tests/configureStore.test.ts"
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/configureStore.typetest.ts" "packages/toolkit/src/tests/configureStore.typetest.ts"
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/getDefaultMiddleware.test.ts" "packages/toolkit/src/tests/getDefaultMiddleware.test.ts"

# Run the specific test files using vitest
cd packages/toolkit
npx vitest run src/query/tests/cacheCollection.test.ts src/tests/EnhancerArray.typetest.ts src/tests/MiddlewareArray.typetest.ts src/tests/autoBatchEnhancer.test.ts src/tests/configureStore.test.ts src/tests/configureStore.typetest.ts src/tests/getDefaultMiddleware.test.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
