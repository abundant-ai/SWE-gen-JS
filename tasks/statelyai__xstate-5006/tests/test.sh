#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/setup.types.test.ts" "packages/core/test/setup.types.test.ts"

# Rebuild to pick up source file changes from fix.patch
# Build may get killed due to memory constraints, but partial build is sufficient for typecheck
yarn build 2>&1 || true

# Run TypeScript type-check to catch type errors (this is a type-level fix)
yarn typecheck
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
