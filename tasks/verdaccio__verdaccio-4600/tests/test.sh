#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/tarball/tests/assets"
cp "/tests/packages/core/tarball/tests/assets/tarball.tar" "packages/core/tarball/tests/assets/tarball.tar"
mkdir -p "packages/core/tarball/tests/assets"
cp "/tests/packages/core/tarball/tests/assets/tarball.tgz" "packages/core/tarball/tests/assets/tarball.tgz"
mkdir -p "packages/core/tarball/tests"
cp "/tests/packages/core/tarball/tests/getTarballDetails.spec.ts" "packages/core/tarball/tests/getTarballDetails.spec.ts"
mkdir -p "packages/store/test"
cp "/tests/packages/store/test/storage.spec.ts" "packages/store/test/storage.spec.ts"

# Reinstall dependencies after fix.patch (package.json and pnpm-lock.yaml changed)
pnpm install --frozen-lockfile

# Rebuild after applying fix.patch (TypeScript changes need recompilation)
pnpm run build

# Run tests for the specific packages affected by this PR
TZ=UTC NODE_ENV=test pnpm --filter "@verdaccio/tarball" test -- --coverage=false
tarball_status=$?

TZ=UTC NODE_ENV=test pnpm --filter "@verdaccio/store" test -- --coverage=false
store_status=$?

# Both packages must pass
if [ $tarball_status -eq 0 ] && [ $store_status -eq 0 ]; then
  test_status=0
else
  test_status=1
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
