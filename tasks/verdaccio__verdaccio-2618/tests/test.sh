#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/utils/test"
cp "/tests/packages/utils/test/utils.spec.ts" "packages/utils/test/utils.spec.ts"
mkdir -p "packages/web/test"
cp "/tests/packages/web/test/utils.spec.ts" "packages/web/test/utils.spec.ts"

# Reinstall dependencies after fix.patch (package.json and pnpm-lock.yaml may have changed)
pnpm install --no-frozen-lockfile

# Rebuild the TypeScript project after applying fix.patch
pnpm run build

# Temporarily rename the corrupted package.json files to avoid jest haste-map errors
mv packages/server/test/api/mock/store/corrupted-package/package.json packages/server/test/api/mock/store/corrupted-package/package.json.bak 2>/dev/null || true
mv packages/server/test/storage/mock/store/corrupted-package/package.json packages/server/test/storage/mock/store/corrupted-package/package.json.bak 2>/dev/null || true

# Run the specific test files from this PR (run from each package directory)
cd packages/utils
TZ=UTC NODE_ENV=test BABEL_ENV=test npx jest test/utils.spec.ts --coverage=false
utils_status=$?

cd ../web
TZ=UTC NODE_ENV=test BABEL_ENV=test npx jest test/utils.spec.ts --coverage=false
web_status=$?

cd /app/src

# Both tests must pass
if [ $utils_status -eq 0 ] && [ $web_status -eq 0 ]; then
    test_status=0
else
    test_status=1
fi

# Restore the corrupted package.json files
mv packages/server/test/api/mock/store/corrupted-package/package.json.bak packages/server/test/api/mock/store/corrupted-package/package.json 2>/dev/null || true
mv packages/server/test/storage/mock/store/corrupted-package/package.json.bak packages/server/test/storage/mock/store/corrupted-package/package.json 2>/dev/null || true

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
