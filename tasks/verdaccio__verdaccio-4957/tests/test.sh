#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/auth/test"
cp "/tests/packages/auth/test/auth-utils.spec.ts" "packages/auth/test/auth-utils.spec.ts"
mkdir -p "packages/auth/test"
cp "/tests/packages/auth/test/auth.spec.ts" "packages/auth/test/auth.spec.ts"

# Rebuild after applying fix.patch (TypeScript changes need recompilation)
pnpm build

# Run vitest on the specific test files for this PR from the auth directory
cd packages/auth
TZ=UTC npx vitest run \
  test/auth-utils.spec.ts \
  test/auth.spec.ts \
  --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
