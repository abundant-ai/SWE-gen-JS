#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "integration/scopes/e2e"
cp "/tests/integration/scopes/e2e/transient-scope.spec.ts" "integration/scopes/e2e/transient-scope.spec.ts"
mkdir -p "packages/core/test/injector"
cp "/tests/packages/core/test/injector/nested-transient-isolation.spec.ts" "packages/core/test/injector/nested-transient-isolation.spec.ts"

# Run the specific test files using mocha
npx mocha integration/scopes/e2e/transient-scope.spec.ts packages/core/test/injector/nested-transient-isolation.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
