#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/loaders/test/partials/config"
cp "/tests/packages/loaders/test/partials/config/no-plugin.yaml" "packages/loaders/test/partials/config/no-plugin.yaml"
mkdir -p "packages/loaders/test"
cp "/tests/packages/loaders/test/plugin_loader_async.spec.ts" "packages/loaders/test/plugin_loader_async.spec.ts"

# Run the specific test file with vitest (disable coverage for subset)
# Path is relative to the package directory when using --filter
pnpm --filter @verdaccio/loaders test test/plugin_loader_async.spec.ts --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
