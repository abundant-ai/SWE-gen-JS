#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "integration/hooks/e2e"
cp "/tests/integration/hooks/e2e/enable-shutdown-hook.spec.ts" "integration/hooks/e2e/enable-shutdown-hook.spec.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/nest-application-context.spec.ts" "packages/core/test/nest-application-context.spec.ts"

# Run the specific test files using mocha
npx mocha integration/hooks/e2e/enable-shutdown-hook.spec.ts packages/core/test/nest-application-context.spec.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
