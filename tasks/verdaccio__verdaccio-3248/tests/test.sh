#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/web/test/config"
cp "/tests/packages/web/test/config/web.yaml" "packages/web/test/config/web.yaml"
mkdir -p "packages/web/test"
cp "/tests/packages/web/test/render.test.ts" "packages/web/test/render.test.ts"
mkdir -p "packages/web/test"
cp "/tests/packages/web/test/utils.spec.ts" "packages/web/test/utils.spec.ts"

# Reinstall dependencies after fix.patch (package.json and pnpm-lock.yaml changed)
pnpm install --frozen-lockfile

# Rebuild after applying fix.patch (TypeScript changes need recompilation)
pnpm run build

# Run only the web package tests (relevant for this PR)
cd packages/web
TZ=UTC NODE_ENV=test npx jest --config jest.config.js test/render.test.ts test/utils.spec.ts --coverage=false
test_status=$?
cd /app/src

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
