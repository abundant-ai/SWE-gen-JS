#!/bin/bash

set -o pipefail

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/input.test.ts" "packages/core/test/input.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/typegenTypes.test.ts" "packages/core/test/typegenTypes.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/types.test.ts" "packages/core/test/types.test.ts"

# For type-only PRs, run TypeScript type-checking using the project's yarn typecheck command
# This validates @ts-expect-error annotations - unused annotations cause errors
yarn typecheck 2>&1 | tee /tmp/typecheck.log
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
