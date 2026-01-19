#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/emit.test.ts" "packages/core/test/emit.test.ts"

# Rebuild to pick up source file changes from fix.patch
yarn build

# Run jest on specific test files
yarn jest packages/core/test/emit.test.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
