#!/bin/bash

set -o pipefail

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/final.test.ts" "packages/core/test/final.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/invoke.test.ts" "packages/core/test/invoke.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/predictableExec.test.ts" "packages/core/test/predictableExec.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/system.test.ts" "packages/core/test/system.test.ts"

# Run Jest on the specific test files (disable coverage, run with single worker to avoid OOM)
npx jest \
  packages/core/test/final.test.ts \
  packages/core/test/invoke.test.ts \
  packages/core/test/predictableExec.test.ts \
  packages/core/test/system.test.ts \
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
