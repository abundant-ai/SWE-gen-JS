#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/store/test"
cp "/tests/packages/store/test/storage-utils.spec.ts" "packages/store/test/storage-utils.spec.ts"

# Rebuild after applying fix.patch (TypeScript changes need recompilation)
pnpm build

# Run vitest on the specific test file for this PR
npx vitest run \
  packages/store/test/storage-utils.spec.ts \
  --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
