#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/core/test"
cp "/tests/packages/core/core/test/validation-utilts.spec.ts" "packages/core/core/test/validation-utilts.spec.ts"
mkdir -p "packages/middleware/test"
cp "/tests/packages/middleware/test/params.spec.ts" "packages/middleware/test/params.spec.ts"
mkdir -p "packages/middleware/test"
cp "/tests/packages/middleware/test/validation.spec.ts" "packages/middleware/test/validation.spec.ts"

# Reinstall dependencies after fix.patch (package.json and pnpm-lock.yaml changed)
pnpm install --frozen-lockfile

# Rebuild after applying fix.patch (TypeScript changes need recompilation)
pnpm run build

# Run only the specific test files affected by this PR
cd packages/core/core
TZ=UTC NODE_ENV=test npx jest test/validation-utilts.spec.ts --coverage=false
core_status=$?
cd /app/src

cd packages/middleware
TZ=UTC NODE_ENV=test npx jest test/params.spec.ts test/validation.spec.ts --coverage=false
middleware_status=$?
cd /app/src

# Both test files must pass
if [ $core_status -eq 0 ] && [ $middleware_status -eq 0 ]; then
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
