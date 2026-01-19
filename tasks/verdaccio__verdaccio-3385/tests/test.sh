#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/store/test/fixtures/config"
cp "/tests/packages/store/test/fixtures/config/deprecate.yaml" "packages/store/test/fixtures/config/deprecate.yaml"
mkdir -p "packages/store/test"
cp "/tests/packages/store/test/storage.spec.ts" "packages/store/test/storage.spec.ts"
mkdir -p "test/cli"
cp "/tests/cli/README.md" "test/cli/README.md"
mkdir -p "test/cli/cli-commons/src"
cp "/tests/cli/cli-commons/src/process.ts" "test/cli/cli-commons/src/process.ts"
mkdir -p "test/cli/cli-commons/src"
cp "/tests/cli/cli-commons/src/registry.ts" "test/cli/cli-commons/src/registry.ts"
mkdir -p "test/cli/e2e-npm6"
cp "/tests/cli/e2e-npm6/deprecate.spec.ts" "test/cli/e2e-npm6/deprecate.spec.ts"
mkdir -p "test/cli/e2e-npm6"
cp "/tests/cli/e2e-npm6/jest.config.js" "test/cli/e2e-npm6/jest.config.js"
mkdir -p "test/cli/e2e-npm6"
cp "/tests/cli/e2e-npm6/publish.spec.ts" "test/cli/e2e-npm6/publish.spec.ts"
mkdir -p "test/cli/e2e-npm7"
cp "/tests/cli/e2e-npm7/deprecate.spec.ts" "test/cli/e2e-npm7/deprecate.spec.ts"
mkdir -p "test/cli/e2e-npm7"
cp "/tests/cli/e2e-npm7/jest.config.js" "test/cli/e2e-npm7/jest.config.js"
mkdir -p "test/cli/e2e-npm8"
cp "/tests/cli/e2e-npm8/deprecate.spec.ts" "test/cli/e2e-npm8/deprecate.spec.ts"
mkdir -p "test/cli/e2e-npm8"
cp "/tests/cli/e2e-npm8/jest.config.js" "test/cli/e2e-npm8/jest.config.js"
mkdir -p "test/cli/e2e-pnpm6"
cp "/tests/cli/e2e-pnpm6/deprecate.spec.ts" "test/cli/e2e-pnpm6/deprecate.spec.ts"
mkdir -p "test/cli/e2e-pnpm6"
cp "/tests/cli/e2e-pnpm6/jest.config.js" "test/cli/e2e-pnpm6/jest.config.js"
mkdir -p "test/cli/e2e-pnpm7"
cp "/tests/cli/e2e-pnpm7/deprecate.spec.ts" "test/cli/e2e-pnpm7/deprecate.spec.ts"
mkdir -p "test/cli/e2e-pnpm7"
cp "/tests/cli/e2e-pnpm7/jest.config.js" "test/cli/e2e-pnpm7/jest.config.js"
mkdir -p "test/cli/e2e-yarn1"
cp "/tests/cli/e2e-yarn1/jest.config.js" "test/cli/e2e-yarn1/jest.config.js"
mkdir -p "test/cli/e2e-yarn2"
cp "/tests/cli/e2e-yarn2/info.spec.ts" "test/cli/e2e-yarn2/info.spec.ts"
mkdir -p "test/cli/e2e-yarn2"
cp "/tests/cli/e2e-yarn2/install.spec.ts" "test/cli/e2e-yarn2/install.spec.ts"
mkdir -p "test/cli/e2e-yarn2"
cp "/tests/cli/e2e-yarn2/jest.config.js" "test/cli/e2e-yarn2/jest.config.js"
mkdir -p "test/cli/e2e-yarn3"
cp "/tests/cli/e2e-yarn3/info.spec.ts" "test/cli/e2e-yarn3/info.spec.ts"

# Reinstall dependencies after fix.patch (package.json and pnpm-lock.yaml changed)
pnpm install --frozen-lockfile

# Rebuild after applying fix.patch (TypeScript changes need recompilation)
pnpm run build

# Run only the storage test (most relevant for this PR)
# E2E tests are very slow and not critical for this CI configuration PR
cd packages/store
TZ=UTC NODE_ENV=test npx jest --config jest.config.js test/storage.spec.ts --coverage=false
test_status=$?
cd /app/src

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
