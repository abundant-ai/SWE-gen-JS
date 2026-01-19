#!/bin/bash

cd /app/src

# Reinstall dependencies in case package.json was modified by agent
yarn install

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/rtk-query-codegen-openapi/test/mocks"
cp "/tests/packages/rtk-query-codegen-openapi/test/mocks/server.ts" "packages/rtk-query-codegen-openapi/test/mocks/server.ts"
mkdir -p "packages/toolkit/src/query/tests"
cp "/tests/packages/toolkit/src/query/tests/buildHooks.test.tsx" "packages/toolkit/src/query/tests/buildHooks.test.tsx"
mkdir -p "packages/toolkit/src/query/tests"
cp "/tests/packages/toolkit/src/query/tests/cacheCollection.test.ts" "packages/toolkit/src/query/tests/cacheCollection.test.ts"
mkdir -p "packages/toolkit/src/query/tests"
cp "/tests/packages/toolkit/src/query/tests/cacheLifecycle.test.ts" "packages/toolkit/src/query/tests/cacheLifecycle.test.ts"
mkdir -p "packages/toolkit/src/query/tests"
cp "/tests/packages/toolkit/src/query/tests/createApi.test.ts" "packages/toolkit/src/query/tests/createApi.test.ts"
mkdir -p "packages/toolkit/src/query/tests"
cp "/tests/packages/toolkit/src/query/tests/devWarnings.test.tsx" "packages/toolkit/src/query/tests/devWarnings.test.tsx"
mkdir -p "packages/toolkit/src/query/tests"
cp "/tests/packages/toolkit/src/query/tests/errorHandling.test.tsx" "packages/toolkit/src/query/tests/errorHandling.test.tsx"
mkdir -p "packages/toolkit/src/query/tests"
cp "/tests/packages/toolkit/src/query/tests/fetchBaseQuery.test.tsx" "packages/toolkit/src/query/tests/fetchBaseQuery.test.tsx"
mkdir -p "packages/toolkit/src/query/tests"
cp "/tests/packages/toolkit/src/query/tests/matchers.test.tsx" "packages/toolkit/src/query/tests/matchers.test.tsx"
mkdir -p "packages/toolkit/src/query/tests/mocks"
cp "/tests/packages/toolkit/src/query/tests/mocks/server.ts" "packages/toolkit/src/query/tests/mocks/server.ts"
mkdir -p "packages/toolkit/src/query/tests"
cp "/tests/packages/toolkit/src/query/tests/queryFn.test.tsx" "packages/toolkit/src/query/tests/queryFn.test.tsx"
mkdir -p "packages/toolkit/src/query/tests"
cp "/tests/packages/toolkit/src/query/tests/queryLifecycle.test.tsx" "packages/toolkit/src/query/tests/queryLifecycle.test.tsx"

# Build packages before running tests
yarn build

# Run Jest tests on the specific test files from this PR (from toolkit package directory)
# Note: server.ts files are mocks, not actual test files, so we only run the .test.* files
cd packages/toolkit
npx jest --runInBand --coverage=false \
  src/query/tests/buildHooks.test.tsx \
  src/query/tests/cacheCollection.test.ts \
  src/query/tests/cacheLifecycle.test.ts \
  src/query/tests/createApi.test.ts \
  src/query/tests/devWarnings.test.tsx \
  src/query/tests/errorHandling.test.tsx \
  src/query/tests/fetchBaseQuery.test.tsx \
  src/query/tests/matchers.test.tsx \
  src/query/tests/queryFn.test.tsx \
  src/query/tests/queryLifecycle.test.tsx
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
