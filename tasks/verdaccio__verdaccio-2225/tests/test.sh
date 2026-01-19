#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/server/test/web"
cp "/tests/packages/server/test/web/index.spec.ts" "packages/server/test/web/index.spec.ts"
mkdir -p "packages/web/test"
cp "/tests/packages/web/test/api.search.test.ts" "packages/web/test/api.search.test.ts"

# Reinstall dependencies after fix.patch (package.json and pnpm-lock.yaml may have changed)
pnpm install --no-frozen-lockfile

# Rebuild the TypeScript project after applying fix.patch
pnpm run build

# Temporarily rename the corrupted package.json files to avoid jest haste-map errors
mv packages/server/test/api/mock/store/corrupted-package/package.json packages/server/test/api/mock/store/corrupted-package/package.json.bak 2>/dev/null || true
mv packages/server/test/storage/mock/store/corrupted-package/package.json packages/server/test/storage/mock/store/corrupted-package/package.json.bak 2>/dev/null || true

# Run the first test file from the server package
cd packages/server
TZ=UTC NODE_ENV=test BABEL_ENV=test npx jest test/web/index.spec.ts --coverage=false
server_status=$?

cd /app/src

# Run the second test file from the web package
cd packages/web
TZ=UTC NODE_ENV=test BABEL_ENV=test npx jest test/api.search.test.ts --coverage=false
web_status=$?

cd /app/src

# Restore the corrupted package.json files
mv packages/server/test/api/mock/store/corrupted-package/package.json.bak packages/server/test/api/mock/store/corrupted-package/package.json 2>/dev/null || true
mv packages/server/test/storage/mock/store/corrupted-package/package.json.bak packages/server/test/storage/mock/store/corrupted-package/package.json 2>/dev/null || true

# Set test status to the first failure, or 0 if both passed
if [ $server_status -ne 0 ]; then
  test_status=$server_status
elif [ $web_status -ne 0 ]; then
  test_status=$web_status
else
  test_status=0
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
