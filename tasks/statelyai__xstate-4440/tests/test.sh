#!/bin/bash

set -o pipefail

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/deterministic.test.ts" "packages/core/test/deterministic.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/interpreter.test.ts" "packages/core/test/interpreter.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/invalid.test.ts" "packages/core/test/invalid.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/machine.test.ts" "packages/core/test/machine.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/meta.test.ts" "packages/core/test/meta.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/microstep.test.ts" "packages/core/test/microstep.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/rehydration.test.ts" "packages/core/test/rehydration.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/state.test.ts" "packages/core/test/state.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/utils.ts" "packages/core/test/utils.ts"
mkdir -p "packages/xstate-graph/test"
cp "/tests/packages/xstate-graph/test/graph.test.ts" "packages/xstate-graph/test/graph.test.ts"

# Run Jest on the specific test files (disable coverage, run with single worker to avoid OOM)
npx jest \
  packages/core/test/deterministic.test.ts \
  packages/core/test/interpreter.test.ts \
  packages/core/test/invalid.test.ts \
  packages/core/test/machine.test.ts \
  packages/core/test/meta.test.ts \
  packages/core/test/microstep.test.ts \
  packages/core/test/rehydration.test.ts \
  packages/core/test/state.test.ts \
  packages/xstate-graph/test/graph.test.ts \
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
