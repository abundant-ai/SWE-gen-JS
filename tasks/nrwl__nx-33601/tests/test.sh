#!/bin/bash

cd /app/src

# Set CI environment variable for tests
export CI=true

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/rollup/src/plugins"
cp "/tests/packages/rollup/src/plugins/nx-copy-assets.plugin.spec.ts" "packages/rollup/src/plugins/nx-copy-assets.plugin.spec.ts"

# Run Jest tests for the specific test file using the Rollup package's config
cd packages/rollup
npx jest src/plugins/nx-copy-assets.plugin.spec.ts --coverage=false --maxWorkers=1 --workerIdleMemoryLimit=512M --config jest.config.cts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
