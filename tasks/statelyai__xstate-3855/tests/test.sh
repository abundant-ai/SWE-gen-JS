#!/bin/bash

cd /app/src

# Clear Jest cache to ensure fresh test run
npx jest --clearCache 2>/dev/null || true

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/actionCreators.test.ts" "packages/core/test/actionCreators.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/types.test.ts" "packages/core/test/types.test.ts"

# Rebuild after copying test files to ensure they can import from updated built files
yarn build

# Run Jest on only the specific test files for this PR
yarn jest \
  packages/core/test/actionCreators.test.ts \
  packages/core/test/types.test.ts \
  --coverage=false --runInBand --no-cache
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
