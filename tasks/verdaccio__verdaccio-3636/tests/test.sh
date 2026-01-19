#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/middleware/test/config"
cp "/tests/packages/middleware/test/config/dark-logo.png" "packages/middleware/test/config/dark-logo.png"
mkdir -p "packages/middleware/test/config"
cp "/tests/packages/middleware/test/config/file-logo.yaml" "packages/middleware/test/config/file-logo.yaml"
mkdir -p "packages/middleware/test/config"
cp "/tests/packages/middleware/test/config/login-disabled.yaml" "packages/middleware/test/config/login-disabled.yaml"
mkdir -p "packages/middleware/test/config"
cp "/tests/packages/middleware/test/config/no-logo.yaml" "packages/middleware/test/config/no-logo.yaml"
mkdir -p "packages/middleware/test/config"
cp "/tests/packages/middleware/test/config/web.yaml" "packages/middleware/test/config/web.yaml"
mkdir -p "packages/middleware/test/config"
cp "/tests/packages/middleware/test/config/wrong-logo.yaml" "packages/middleware/test/config/wrong-logo.yaml"
mkdir -p "packages/middleware/test"
cp "/tests/packages/middleware/test/render.spec.ts" "packages/middleware/test/render.spec.ts"
mkdir -p "packages/web/test/config"
cp "/tests/packages/web/test/config/web.yaml" "packages/web/test/config/web.yaml"

# Reinstall dependencies after fix.patch (package.json and pnpm-lock.yaml changed)
pnpm install --frozen-lockfile

# Rebuild after applying fix.patch (TypeScript changes need recompilation)
pnpm run build

# Run only the specific test file affected by this PR (render.spec.ts tests the middleware)
cd packages/middleware
TZ=UTC NODE_ENV=test npx jest --config jest.config.js test/render.spec.ts --coverage=false
test_status=$?
cd /app/src

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
