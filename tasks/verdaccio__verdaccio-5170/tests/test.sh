#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/loaders/test/partials/test-plugin-storage/verdaccio-plugin"
cp "/tests/packages/loaders/test/partials/test-plugin-storage/verdaccio-plugin/index.js" "packages/loaders/test/partials/test-plugin-storage/verdaccio-plugin/index.js"
mkdir -p "packages/loaders/test"
cp "/tests/packages/loaders/test/plugin_loader_async.spec.ts" "packages/loaders/test/plugin_loader_async.spec.ts"

# Rebuild after applying fix.patch (TypeScript changes need recompilation)
pnpm build

# Run vitest on the specific test files for this PR
npx vitest run packages/loaders/test/plugin_loader_async.spec.ts --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
