#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/hooks/test"
cp "/tests/packages/hooks/test/notify-request.spec.ts" "packages/hooks/test/notify-request.spec.ts"

# Reinstall dependencies after fix.patch (package.json and pnpm-lock.yaml may have changed)
pnpm install --no-frozen-lockfile

# Rebuild the TypeScript project after applying fix.patch
pnpm run build

# Temporarily rename the corrupted package.json files to avoid jest haste-map errors
mv packages/server/test/api/mock/store/corrupted-package/package.json packages/server/test/api/mock/store/corrupted-package/package.json.bak 2>/dev/null || true
mv packages/server/test/storage/mock/store/corrupted-package/package.json packages/server/test/storage/mock/store/corrupted-package/package.json.bak 2>/dev/null || true

# Run the specific test file from this PR (run from the hooks package directory)
cd packages/hooks
TZ=UTC NODE_ENV=test BABEL_ENV=test npx jest test/notify-request.spec.ts --coverage=false
test_status=$?

cd /app/src

# Restore the corrupted package.json files
mv packages/server/test/api/mock/store/corrupted-package/package.json.bak packages/server/test/api/mock/store/corrupted-package/package.json 2>/dev/null || true
mv packages/server/test/storage/mock/store/corrupted-package/package.json.bak packages/server/test/storage/mock/store/corrupted-package/package.json 2>/dev/null || true

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
