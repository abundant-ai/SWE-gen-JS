#!/bin/bash

cd /app/src

# Clear Jest cache to ensure fresh test run
npx jest --clearCache 2>/dev/null || true

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/actorLogic.test.ts" "packages/core/test/actorLogic.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/system.test.ts" "packages/core/test/system.test.ts"

# Run Jest on the specific test files for this PR
npx jest packages/core/test/actorLogic.test.ts packages/core/test/system.test.ts --coverage=false --runInBand --no-cache
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
