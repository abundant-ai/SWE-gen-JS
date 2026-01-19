#!/bin/bash

cd /app/src

# Reinstall dependencies in case package.json was modified by agent
yarn install

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/toolkit/src/tests"
cp "/tests/packages/toolkit/src/tests/serializableStateInvariantMiddleware.test.ts" "packages/toolkit/src/tests/serializableStateInvariantMiddleware.test.ts"

# Build toolkit package with updated code
cd packages/toolkit
rm -rf dist/
yarn build

# Run Jest test on the specific test file
npx jest --runInBand --coverage=false \
  src/tests/serializableStateInvariantMiddleware.test.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
