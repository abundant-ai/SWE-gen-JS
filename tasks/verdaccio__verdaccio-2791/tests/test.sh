#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/unit/modules/api"
cp "/tests/unit/modules/api/api.spec.ts" "test/unit/modules/api/api.spec.ts"
mkdir -p "test/unit/modules/api"
cp "/tests/unit/modules/api/token.spec.ts" "test/unit/modules/api/token.spec.ts"
mkdir -p "test/unit/modules/web"
cp "/tests/unit/modules/web/api.web.spec.ts" "test/unit/modules/web/api.web.spec.ts"

# Reinstall dependencies after fix.patch (package.json and pnpm-lock.yaml may have changed)
pnpm install --no-frozen-lockfile

# Rebuild the TypeScript project after applying fix.patch
pnpm run code:build

# Temporarily rename the corrupted package.json files to avoid jest haste-map errors
mv packages/server/test/api/mock/store/corrupted-package/package.json packages/server/test/api/mock/store/corrupted-package/package.json.bak 2>/dev/null || true
mv packages/server/test/storage/mock/store/corrupted-package/package.json packages/server/test/storage/mock/store/corrupted-package/package.json.bak 2>/dev/null || true

# Run the specific test files from this PR
TZ=UTC pnpm test -- test/unit/modules/api/api.spec.ts test/unit/modules/api/token.spec.ts test/unit/modules/web/api.web.spec.ts --coverage=false
test_status=$?

# Restore the corrupted package.json files
mv packages/server/test/api/mock/store/corrupted-package/package.json.bak packages/server/test/api/mock/store/corrupted-package/package.json 2>/dev/null || true
mv packages/server/test/storage/mock/store/corrupted-package/package.json.bak packages/server/test/storage/mock/store/corrupted-package/package.json 2>/dev/null || true

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
