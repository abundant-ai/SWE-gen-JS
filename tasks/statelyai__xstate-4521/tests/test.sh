#!/bin/bash

set -o pipefail

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/after.test.ts" "packages/core/test/after.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/inspect.test.ts" "packages/core/test/inspect.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/invoke.test.ts" "packages/core/test/invoke.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/json.test.ts" "packages/core/test/json.test.ts"
mkdir -p "packages/xstate-graph/test"
cp "/tests/packages/xstate-graph/test/shortestPaths.test.ts" "packages/xstate-graph/test/shortestPaths.test.ts"

# Run Jest on the specific test files (disable coverage for subset)
yarn jest packages/core/test/after.test.ts packages/core/test/inspect.test.ts packages/core/test/invoke.test.ts packages/core/test/json.test.ts packages/xstate-graph/test/shortestPaths.test.ts --coverage=false 2>&1 | head -200
test_status=${PIPESTATUS[0]}

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
