#!/bin/bash

cd /app/src

# Reinstall dependencies in case package.json was modified by agent
yarn install

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/toolkit/src/query/tests"
cp "/tests/packages/toolkit/src/query/tests/createApi.test.ts" "packages/toolkit/src/query/tests/createApi.test.ts"
mkdir -p "packages/toolkit/src/query/tests"
cp "/tests/packages/toolkit/src/query/tests/errorHandling.test.tsx" "packages/toolkit/src/query/tests/errorHandling.test.tsx"
mkdir -p "packages/toolkit/src/query/tests"
cp "/tests/packages/toolkit/src/query/tests/fetchBaseQuery.test.tsx" "packages/toolkit/src/query/tests/fetchBaseQuery.test.tsx"

# Clear any build artifacts and rebuild with updated code
cd packages/toolkit
rm -rf dist/
yarn build

# Run Jest tests on the specific test files
npx jest --runInBand --coverage=false \
  src/query/tests/createApi.test.ts \
  src/query/tests/errorHandling.test.tsx \
  src/query/tests/fetchBaseQuery.test.tsx
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
