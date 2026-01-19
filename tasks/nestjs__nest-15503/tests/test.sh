#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "integration/hello-world/e2e"
cp "/tests/integration/hello-world/e2e/force-console.spec.ts" "integration/hello-world/e2e/force-console.spec.ts"
mkdir -p "packages/common/test/services"
cp "/tests/packages/common/test/services/logger.service.spec.ts" "packages/common/test/services/logger.service.spec.ts"

# Run the specific test files using mocha separately to avoid shared state issues
npx mocha integration/hello-world/e2e/force-console.spec.ts
test_status=$?

# Only run the second test file if the first one passed
if [ $test_status -eq 0 ]; then
  npx mocha packages/common/test/services/logger.service.spec.ts
  test_status=$?
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
