#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/rtk-query-codegen-openapi/test/__snapshots__"
cp "/tests/packages/rtk-query-codegen-openapi/test/__snapshots__/generateEndpoints.test.ts.snap" "packages/rtk-query-codegen-openapi/test/__snapshots__/generateEndpoints.test.ts.snap"

# Run specific test file with jest (the test file that uses the snapshot)
cd packages/rtk-query-codegen-openapi
npx jest test/generateEndpoints.test.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
