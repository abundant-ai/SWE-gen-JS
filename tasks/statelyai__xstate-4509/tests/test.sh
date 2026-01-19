#!/bin/bash

set -o pipefail

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/actor.test.ts" "packages/core/test/actor.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/inspect.test.ts" "packages/core/test/inspect.test.ts"

# Run Jest on the specific test files (disable coverage for subset)
yarn jest packages/core/test/actor.test.ts packages/core/test/inspect.test.ts --coverage=false 2>&1 | head -200
test_status=${PIPESTATUS[0]}

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
