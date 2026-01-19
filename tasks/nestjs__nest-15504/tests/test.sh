#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "integration/injector/e2e"
cp "/tests/integration/injector/e2e/many-global-modules.spec.ts" "integration/injector/e2e/many-global-modules.spec.ts"
mkdir -p "packages/core/test/injector"
cp "/tests/packages/core/test/injector/injector.spec.ts" "packages/core/test/injector/injector.spec.ts"

# Run the specific test files using mocha
npx mocha integration/injector/e2e/many-global-modules.spec.ts packages/core/test/injector/injector.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
