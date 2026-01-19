#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/signature/test"
cp "/tests/packages/signature/test/legacy-token-deprecated-backward-compatible.spec.ts" "packages/signature/test/legacy-token-deprecated-backward-compatible.spec.ts"
mkdir -p "packages/signature/test"
cp "/tests/packages/signature/test/legacy-token.spec.ts" "packages/signature/test/legacy-token.spec.ts"

# Reinstall dependencies after fix.patch (package.json and pnpm-lock.yaml changed)
pnpm install --frozen-lockfile

# Rebuild after applying fix.patch (TypeScript changes need recompilation)
pnpm run build

# Run tests for the specific package affected by this PR
TZ=UTC NODE_ENV=test pnpm --filter "@verdaccio/signature" test -- --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
