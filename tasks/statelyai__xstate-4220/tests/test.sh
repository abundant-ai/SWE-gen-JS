#!/bin/bash

set -o pipefail

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/types.test.ts" "packages/core/test/types.test.ts"

# This PR adds TypeScript type-level tests that check type narrowing for partial event descriptors.
# Jest uses babel-jest which transpiles but doesn't type-check, so we must run tsc to verify types.
yarn typecheck 2>&1 | tee /tmp/typecheck.log

test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
