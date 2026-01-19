#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/rtk-query-codegen-openapi/test/__snapshots__"
cp "/tests/packages/rtk-query-codegen-openapi/test/__snapshots__/generateEndpoints.test.ts.snap" "packages/rtk-query-codegen-openapi/test/__snapshots__/generateEndpoints.test.ts.snap"
mkdir -p "packages/rtk-query-codegen-openapi/test/fixtures"
cp "/tests/packages/rtk-query-codegen-openapi/test/fixtures/readOnlyWriteOnly.yaml" "packages/rtk-query-codegen-openapi/test/fixtures/readOnlyWriteOnly.yaml"
mkdir -p "packages/rtk-query-codegen-openapi/test"
cp "/tests/packages/rtk-query-codegen-openapi/test/generateEndpoints.test.ts" "packages/rtk-query-codegen-openapi/test/generateEndpoints.test.ts"

# Run the specific test file using jest
cd packages/rtk-query-codegen-openapi
npx jest test/generateEndpoints.test.ts --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
