#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/toolkit/src/query/tests"
cp "/tests/packages/toolkit/src/query/tests/createApi.test.ts" "packages/toolkit/src/query/tests/createApi.test.ts"

# Rebuild after copying updated test file
yarn build

# Run the specific test file using Jest
cd packages/toolkit
npx jest src/query/tests/createApi.test.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
