#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/logger/logger-commons/test"
cp "/tests/packages/logger/logger-commons/test/logger.spec.ts" "packages/logger/logger-commons/test/logger.spec.ts"
mkdir -p "packages/logger/logger-prettify/test/__snapshots__"
cp "/tests/packages/logger/logger-prettify/test/__snapshots__/formatter.spec.ts.snap" "packages/logger/logger-prettify/test/__snapshots__/formatter.spec.ts.snap"
mkdir -p "packages/logger/logger-prettify/test"
cp "/tests/packages/logger/logger-prettify/test/index.spec.ts" "packages/logger/logger-prettify/test/index.spec.ts"
mkdir -p "packages/logger/logger-prettify/test"
cp "/tests/packages/logger/logger-prettify/test/utils.test.ts" "packages/logger/logger-prettify/test/utils.test.ts"

# Reinstall dependencies after fix.patch (package.json and pnpm-lock.yaml changed)
pnpm install --frozen-lockfile

# Rebuild after applying fix.patch (TypeScript changes need recompilation)
pnpm run build

# Run tests for the specific packages affected by this PR
# Using pnpm --filter to run tests in the specific workspace packages
TZ=UTC NODE_ENV=test pnpm --filter "@verdaccio/logger-commons" test -- --coverage=false
test_status_1=$?

TZ=UTC NODE_ENV=test pnpm --filter "@verdaccio/logger-prettify" test -- --coverage=false
test_status_2=$?

# Overall status is success only if both passed
if [ $test_status_1 -eq 0 ] && [ $test_status_2 -eq 0 ]; then
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
