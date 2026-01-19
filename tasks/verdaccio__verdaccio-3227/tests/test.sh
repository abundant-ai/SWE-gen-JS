#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/unit/modules/plugin"
cp "/tests/unit/modules/plugin/plugin_loader.spec.ts" "test/unit/modules/plugin/plugin_loader.spec.ts"

# Restore binary file that patch command couldn't handle
# The Oracle agent applies fix.patch but can't handle binary files, so we manually restore it
mkdir -p .yarn/cache
cp /tmp/yarn-binary-cache/@verdaccio-scope-verdaccio-auth-foo-npm-0.0.2-e8d6fdf0d9-99f4727a67.zip .yarn/cache/ 2>/dev/null || true

# Reinstall dependencies after fix.patch (package.json and pnpm-lock.yaml changed)
pnpm install --no-frozen-lockfile

# Run only the specific test file for this PR
TZ=UTC NODE_ENV=test npx jest test/unit/modules/plugin/plugin_loader.spec.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
