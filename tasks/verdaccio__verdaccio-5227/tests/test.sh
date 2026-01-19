#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/auth/test"
cp "/tests/packages/auth/test/auth-utils-middleware.spec.ts" "packages/auth/test/auth-utils-middleware.spec.ts"
mkdir -p "packages/signature/test"
cp "/tests/packages/signature/test/jwt.spec.ts" "packages/signature/test/jwt.spec.ts"

# Rebuild after applying fix.patch (TypeScript changes need recompilation)
pnpm build

# Run vitest on the specific test files for this PR
npx vitest run packages/auth/test/auth-utils-middleware.spec.ts packages/signature/test/jwt.spec.ts --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
