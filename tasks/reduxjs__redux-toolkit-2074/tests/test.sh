#!/bin/bash

cd /app/src

# Reinstall dependencies in case package.json was modified by agent
yarn install

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/toolkit/src/listenerMiddleware/tests"
cp "/tests/packages/toolkit/src/listenerMiddleware/tests/fork.test.ts" "packages/toolkit/src/listenerMiddleware/tests/fork.test.ts"

# Clear any build artifacts and rebuild with updated code
cd packages/toolkit
rm -rf dist/
yarn build

# Run Jest tests on the specific test files
npx jest --runInBand --coverage=false \
  src/listenerMiddleware/tests/fork.test.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
