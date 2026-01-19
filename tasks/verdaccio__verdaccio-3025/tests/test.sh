#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/plugins/htpasswd/tests/__fixtures__"
cp "/tests/packages/plugins/htpasswd/tests/__fixtures__/htpasswd" "packages/plugins/htpasswd/tests/__fixtures__/htpasswd"
mkdir -p "packages/plugins/htpasswd/tests"
cp "/tests/packages/plugins/htpasswd/tests/htpasswd.test.ts" "packages/plugins/htpasswd/tests/htpasswd.test.ts"
mkdir -p "packages/plugins/htpasswd/tests"
cp "/tests/packages/plugins/htpasswd/tests/utils.test.ts" "packages/plugins/htpasswd/tests/utils.test.ts"

# Reinstall dependencies after fix.patch (package.json and pnpm-lock.yaml may have changed)
pnpm install --no-frozen-lockfile

# Temporarily rename the corrupted package.json files to avoid jest haste-map errors
mv packages/server/test/api/mock/store/corrupted-package/package.json packages/server/test/api/mock/store/corrupted-package/package.json.bak 2>/dev/null || true
mv packages/server/test/storage/mock/store/corrupted-package/package.json packages/server/test/storage/mock/store/corrupted-package/package.json.bak 2>/dev/null || true

# Run the tests from the htpasswd package directory using its test script
cd packages/plugins/htpasswd
TZ=UTC pnpm test -- tests/htpasswd.test.ts tests/utils.test.ts --coverage=false
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
