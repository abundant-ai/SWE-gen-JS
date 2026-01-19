#!/bin/bash

cd /app/src

export CI=true
export TEST_ADAPTER=sqlite
export DATABASE_URL=file:./dev.db

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "tests/api-tests"
cp "/tests/api-tests/admin-meta.test.ts" "tests/api-tests/admin-meta.test.ts"

# Rebuild the project to pick up any source code changes (e.g., from fix.patch applied by oracle)
yarn build
build_status=$?

if [ $build_status -ne 0 ]; then
  echo 0 > /logs/verifier/reward.txt
  exit $build_status
fi

# Run only the specific test file from this PR using Jest
# Using --runInBand to avoid memory issues with parallel test execution
yarn jest \
  tests/api-tests/admin-meta.test.ts \
  --coverage=false \
  --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
