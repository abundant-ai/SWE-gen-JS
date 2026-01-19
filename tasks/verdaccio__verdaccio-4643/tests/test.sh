#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/unit/modules/bootstrap"
cp "/tests/unit/modules/bootstrap/legacy.spec.ts" "test/unit/modules/bootstrap/legacy.spec.ts"
mkdir -p "test/unit/modules/bootstrap"
cp "/tests/unit/modules/bootstrap/run-server.spec.ts" "test/unit/modules/bootstrap/run-server.spec.ts"
mkdir -p "test/unit/modules/cli"
cp "/tests/unit/modules/cli/cli.spec.ts" "test/unit/modules/cli/cli.spec.ts"
mkdir -p "test/unit/modules/config"
cp "/tests/unit/modules/config/config.spec.ts" "test/unit/modules/config/config.spec.ts"
mkdir -p "test/unit/modules/utils"
cp "/tests/unit/modules/utils/api.__test.template.ts" "test/unit/modules/utils/api.__test.template.ts"

# Reinstall dependencies after fix.patch (package.json and yarn.lock changed)
yarn install --immutable

# Rebuild after applying fix.patch (TypeScript changes need recompilation)
yarn build

# Run jest on the specific test files for this PR
TZ=UTC NODE_ENV=test npx jest \
  test/unit/modules/bootstrap/legacy.spec.ts \
  test/unit/modules/bootstrap/run-server.spec.ts \
  test/unit/modules/cli/cli.spec.ts \
  test/unit/modules/config/config.spec.ts \
  test/unit/modules/utils/api.__test.template.ts \
  --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
