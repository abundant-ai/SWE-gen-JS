#!/bin/bash

cd /app/src

export CI=true
export TEST_ADAPTER=sqlite

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/api-tests/queries"
cp "/tests/api-tests/queries/singletons.test.ts" "tests/api-tests/queries/singletons.test.ts"
mkdir -p "tests/sandbox/configs"
cp "/tests/sandbox/configs/all-the-things.ts" "tests/sandbox/configs/all-the-things.ts"

# Rebuild the project to pick up any source code changes (e.g., from fix.patch applied by oracle)
yarn build
build_status=$?

if [ $build_status -ne 0 ]; then
  echo 0 > /logs/verifier/reward.txt
  exit $build_status
fi

# Run the specific test files for this PR
yarn jest tests/api-tests/queries/singletons.test.ts tests/sandbox/configs/all-the-things.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
