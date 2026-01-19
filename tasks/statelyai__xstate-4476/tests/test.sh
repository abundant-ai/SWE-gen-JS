#!/bin/bash

set -o pipefail

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/rehydration.test.ts" "packages/core/test/rehydration.test.ts"

# Clear Jest cache to ensure fresh compilation
npx jest --clearCache

# Run Jest on the specific test files (disable coverage for partial runs)
npx jest packages/core/test/rehydration.test.ts \
  --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
