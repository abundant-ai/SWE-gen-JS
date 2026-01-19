#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/types-test/plugins/middleware"
cp "/tests/types-test/plugins/middleware/example.middleware.plugin.ts" "test/types-test/plugins/middleware/example.middleware.plugin.ts"
mkdir -p "test/unit/__helper"
cp "/tests/unit/__helper/helper.ts" "test/unit/__helper/helper.ts"
mkdir -p "test/unit/__helper"
cp "/tests/unit/__helper/mock.ts" "test/unit/__helper/mock.ts"
mkdir -p "test/unit/modules/api"
cp "/tests/unit/modules/api/_helper.ts" "test/unit/modules/api/_helper.ts"
mkdir -p "test/unit/modules/api"
cp "/tests/unit/modules/api/publish.spec.ts" "test/unit/modules/api/publish.spec.ts"
mkdir -p "test/unit/modules/web"
cp "/tests/unit/modules/web/api.web.spec.ts" "test/unit/modules/web/api.web.spec.ts"

# The PR updates TypeScript type dependencies
# Type-check the updated test files to verify they're compatible with current dependencies
yarn tsc --noEmit
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
