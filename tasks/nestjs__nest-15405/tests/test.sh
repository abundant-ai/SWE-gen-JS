#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "integration/injector/e2e"
cp "/tests/integration/injector/e2e/many-global-modules.spec.ts" "integration/injector/e2e/many-global-modules.spec.ts"
mkdir -p "packages/core/test/helpers"
cp "/tests/packages/core/test/helpers/barrier.spec.ts" "packages/core/test/helpers/barrier.spec.ts"
mkdir -p "packages/core/test/injector"
cp "/tests/packages/core/test/injector/injector.spec.ts" "packages/core/test/injector/injector.spec.ts"
mkdir -p "packages/core/test/pipes"
cp "/tests/packages/core/test/pipes/pipes-consumer.spec.ts" "packages/core/test/pipes/pipes-consumer.spec.ts"

# Run the specific test files using mocha separately to avoid shared state issues
npx mocha integration/injector/e2e/many-global-modules.spec.ts
test_status=$?

# Only run remaining tests if previous ones passed
if [ $test_status -eq 0 ]; then
  npx mocha packages/core/test/helpers/barrier.spec.ts
  test_status=$?
fi

if [ $test_status -eq 0 ]; then
  npx mocha packages/core/test/injector/injector.spec.ts
  test_status=$?
fi

if [ $test_status -eq 0 ]; then
  npx mocha packages/core/test/pipes/pipes-consumer.spec.ts
  test_status=$?
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
