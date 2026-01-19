#!/bin/bash

set -o pipefail

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/xstate-graph/test"
cp "/tests/packages/xstate-graph/test/graph.test.ts" "packages/xstate-graph/test/graph.test.ts"
cp "/tests/packages/xstate-graph/test/shortestPaths.test.ts" "packages/xstate-graph/test/shortestPaths.test.ts"
cp "/tests/packages/xstate-graph/test/types.test.ts" "packages/xstate-graph/test/types.test.ts"

# Run Jest on only the specific test files for this PR
npx jest \
  packages/xstate-graph/test/graph.test.ts \
  packages/xstate-graph/test/shortestPaths.test.ts \
  packages/xstate-graph/test/types.test.ts \
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
