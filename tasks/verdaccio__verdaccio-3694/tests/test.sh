#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/auth/test"
cp "/tests/packages/auth/test/auth.spec.ts" "packages/auth/test/auth.spec.ts"
mkdir -p "packages/plugins/htpasswd/tests"
cp "/tests/packages/plugins/htpasswd/tests/htpasswd.test.ts" "packages/plugins/htpasswd/tests/htpasswd.test.ts"
mkdir -p "packages/plugins/htpasswd/tests"
cp "/tests/packages/plugins/htpasswd/tests/utils.test.ts" "packages/plugins/htpasswd/tests/utils.test.ts"

# Reinstall dependencies after fix.patch (package.json and pnpm-lock.yaml changed)
pnpm install --frozen-lockfile

# Rebuild after applying fix.patch (TypeScript changes need recompilation)
pnpm run build

# Run only the specific test files affected by this PR
cd packages/auth
TZ=UTC NODE_ENV=test npx jest test/auth.spec.ts --coverage=false
auth_status=$?
cd /app/src

cd packages/plugins/htpasswd
TZ=UTC NODE_ENV=test npx jest tests/htpasswd.test.ts tests/utils.test.ts --coverage=false
htpasswd_status=$?
cd /app/src

# All test files must pass
if [ $auth_status -eq 0 ] && [ $htpasswd_status -eq 0 ]; then
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
