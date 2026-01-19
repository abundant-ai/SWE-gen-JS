#!/bin/bash

cd /app/src

# Clear Jest cache to ensure fresh test run
npx jest --clearCache 2>/dev/null || true

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/actions.test.ts" "packages/core/test/actions.test.ts"

# Rebuild after copying test files to ensure they can import from updated built files
yarn build

# Run Jest on only the specific test file for this PR
yarn jest \
  packages/core/test/actions.test.ts \
  --coverage=false --runInBand --no-cache
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
