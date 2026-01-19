#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/xstate-fsm/test"
cp "/tests/packages/xstate-fsm/test/fsm.test.ts" "packages/xstate-fsm/test/fsm.test.ts"
mkdir -p "packages/xstate-fsm/test"
cp "/tests/packages/xstate-fsm/test/types.test.ts" "packages/xstate-fsm/test/types.test.ts"

# Run Jest on the specific test files for this PR
npx jest packages/xstate-fsm/test/fsm.test.ts packages/xstate-fsm/test/types.test.ts --coverage=false --runInBand
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
