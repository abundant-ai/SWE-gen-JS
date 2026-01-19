#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/web/test"
cp "/tests/packages/web/test/author-utils.spec.ts" "packages/web/test/author-utils.spec.ts"
mkdir -p "packages/web/test"
cp "/tests/packages/web/test/web-utils.spec.ts" "packages/web/test/web-utils.spec.ts"

# Rebuild after applying fix.patch (TypeScript changes need recompilation)
pnpm build

# Run vitest on the specific test files for this PR
cd packages/web
npx vitest run test/author-utils.spec.ts test/web-utils.spec.ts --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
