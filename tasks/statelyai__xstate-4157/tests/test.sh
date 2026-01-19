#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/actions.test.ts" "packages/core/test/actions.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/actor.test.ts" "packages/core/test/actor.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/actorLogic.test.ts" "packages/core/test/actorLogic.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/input.test.ts" "packages/core/test/input.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/invoke.test.ts" "packages/core/test/invoke.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/predictableExec.test.ts" "packages/core/test/predictableExec.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/system.test.ts" "packages/core/test/system.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/typegenTypes.test.ts" "packages/core/test/typegenTypes.test.ts"

# Run Jest on the core test files only (framework tests have module resolution issues in this environment)
npx jest packages/core/test/actions.test.ts packages/core/test/actor.test.ts packages/core/test/actorLogic.test.ts packages/core/test/input.test.ts packages/core/test/invoke.test.ts packages/core/test/predictableExec.test.ts packages/core/test/system.test.ts packages/core/test/typegenTypes.test.ts --coverage=false --maxWorkers=2
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
