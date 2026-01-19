#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/after.test.ts" "packages/core/test/after.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/deterministic.test.ts" "packages/core/test/deterministic.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/eventDescriptors.test.ts" "packages/core/test/eventDescriptors.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/json.test.ts" "packages/core/test/json.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/machine.test.ts" "packages/core/test/machine.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/scxml.test.ts" "packages/core/test/scxml.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/transient.test.ts" "packages/core/test/transient.test.ts"

# Run Jest on the specific test files for this PR
npx jest packages/core/test/after.test.ts packages/core/test/deterministic.test.ts packages/core/test/eventDescriptors.test.ts packages/core/test/json.test.ts packages/core/test/machine.test.ts packages/core/test/scxml.test.ts packages/core/test/transient.test.ts --coverage=false --maxWorkers=2
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
