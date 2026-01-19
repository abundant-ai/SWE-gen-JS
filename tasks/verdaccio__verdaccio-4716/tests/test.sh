#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/middleware/test/config"
cp "/tests/packages/middleware/test/config/favicon.ico" "packages/middleware/test/config/favicon.ico"
mkdir -p "packages/middleware/test/config"
cp "/tests/packages/middleware/test/config/file-logo.yaml" "packages/middleware/test/config/file-logo.yaml"
mkdir -p "packages/middleware/test/config"
cp "/tests/packages/middleware/test/config/http-logo.yaml" "packages/middleware/test/config/http-logo.yaml"
mkdir -p "packages/middleware/test/config"
cp "/tests/packages/middleware/test/config/no-logo.yaml" "packages/middleware/test/config/no-logo.yaml"
mkdir -p "packages/middleware/test"
cp "/tests/packages/middleware/test/render.spec.ts" "packages/middleware/test/render.spec.ts"

# Rebuild after applying fix.patch (TypeScript changes need recompilation)
pnpm build

# Run jest on the specific test file for this PR (middleware uses jest, not vitest)
# Run from the middleware package directory to use its jest config
cd packages/middleware
TZ=UTC npx jest test/render.spec.ts --coverage=false
test_status=$?
cd /app/src

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
