#!/bin/bash

cd /app/src

export CI=true
export TEST_ADAPTER=sqlite
export DATABASE_URL="file:./test.db"

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/src/fields/types/multiselect/tests"
cp "/tests/packages/core/src/fields/types/multiselect/tests/test-fixtures.ts" "packages/core/src/fields/types/multiselect/tests/test-fixtures.ts"
mkdir -p "tests/sandbox/configs"
cp "/tests/sandbox/configs/all-the-things.ts" "tests/sandbox/configs/all-the-things.ts"
mkdir -p "tests/sandbox"
cp "/tests/sandbox/schema.graphql" "tests/sandbox/schema.graphql"
mkdir -p "tests/sandbox"
cp "/tests/sandbox/schema.prisma" "tests/sandbox/schema.prisma"

# Rebuild the project to pick up any source code changes (e.g., from fix.patch applied by oracle)
yarn build
build_status=$?

if [ $build_status -ne 0 ]; then
  echo 0 > /logs/verifier/reward.txt
  exit $build_status
fi

# Run only the multiselect CRUD tests using Jest's test name filter
yarn jest tests/api-tests/fields/crud.test.ts -t "multiselect" --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
