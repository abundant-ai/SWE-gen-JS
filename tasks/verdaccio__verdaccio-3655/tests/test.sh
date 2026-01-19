#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/node-api/test"
cp "/tests/packages/node-api/test/run-server.spec.ts" "packages/node-api/test/run-server.spec.ts"

# Reinstall dependencies after fix.patch (package.json and pnpm-lock.yaml changed)
pnpm install --frozen-lockfile

# Rebuild after applying fix.patch (TypeScript changes need recompilation)
pnpm run build

# Run only the specific test file affected by this PR
cd packages/node-api
TZ=UTC NODE_ENV=test npx jest --config jest.config.js test/run-server.spec.ts --coverage=false
test_status=$?
cd /app/src

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
