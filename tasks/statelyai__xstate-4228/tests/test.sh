#!/bin/bash

set -o pipefail

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/actions.test.ts" "packages/core/test/actions.test.ts"
cp "/tests/packages/core/test/guards.test.ts" "packages/core/test/guards.test.ts"
cp "/tests/packages/core/test/types.test.ts" "packages/core/test/types.test.ts"

# Run Jest on only the specific test files for this PR
npx jest \
  packages/core/test/actions.test.ts \
  packages/core/test/guards.test.ts \
  packages/core/test/types.test.ts \
  --coverage=false \
  --maxWorkers=1 \
  --testTimeout=30000 2>&1 | tee /tmp/jest.log

test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
