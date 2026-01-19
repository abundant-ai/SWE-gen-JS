#!/bin/bash

cd /app/src

# Reinstall dependencies in case package.json was modified by agent
yarn install

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/mapBuilders.typetest.ts" "packages/toolkit/src/tests/mapBuilders.typetest.ts"

# Run type tests on the specific test file from this PR (from toolkit package directory)
# Type tests are compiled with tsc to verify they type-check correctly
cd packages/toolkit
yarn tsc -p src/tests
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
