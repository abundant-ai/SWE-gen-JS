#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/config/test"
cp "/tests/packages/config/test/address.spec.ts" "packages/config/test/address.spec.ts"
mkdir -p "packages/config/test"
cp "/tests/packages/config/test/parse.spec.ts" "packages/config/test/parse.spec.ts"

# Rebuild after applying fix.patch (TypeScript changes need recompilation)
pnpm build

# Run vitest on the specific test files for this PR
cd packages/config
npx vitest run test/address.spec.ts test/parse.spec.ts --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
