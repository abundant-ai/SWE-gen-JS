#!/bin/bash

cd /app/src

# Reinstall dependencies in case package.json was modified by agent
yarn install

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/rtk-query-codegen-openapi/test/__snapshots__"
cp "/tests/packages/rtk-query-codegen-openapi/test/__snapshots__/generateEndpoints.test.ts.snap" "packages/rtk-query-codegen-openapi/test/__snapshots__/generateEndpoints.test.ts.snap"
mkdir -p "packages/rtk-query-codegen-openapi/test"
cp "/tests/packages/rtk-query-codegen-openapi/test/generateEndpoints.test.ts" "packages/rtk-query-codegen-openapi/test/generateEndpoints.test.ts"

# Clear any build artifacts and rebuild with updated code
cd packages/rtk-query-codegen-openapi
rm -rf lib/
yarn build

# Run Jest tests on the specific test files
npx jest --runInBand --coverage=false \
  test/generateEndpoints.test.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
