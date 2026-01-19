#!/bin/bash

cd /app/src

# Set CI environment variable for tests
export CI=true
export NX_DAEMON=false
export NX_SKIP_NX_CACHE=true

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/nx/src/plugins/js/lock-file"
cp "/tests/packages/nx/src/plugins/js/lock-file/npm-parser.spec.ts" "packages/nx/src/plugins/js/lock-file/npm-parser.spec.ts"
mkdir -p "packages/nx/src/plugins/js/lock-file"
cp "/tests/packages/nx/src/plugins/js/lock-file/pnpm-parser.spec.ts" "packages/nx/src/plugins/js/lock-file/pnpm-parser.spec.ts"
mkdir -p "packages/nx/src/plugins/js/lock-file"
cp "/tests/packages/nx/src/plugins/js/lock-file/yarn-parser.spec.ts" "packages/nx/src/plugins/js/lock-file/yarn-parser.spec.ts"

# Run Jest tests for the specific test files using the nx package's config
cd packages/nx
npx jest src/plugins/js/lock-file/npm-parser.spec.ts src/plugins/js/lock-file/pnpm-parser.spec.ts src/plugins/js/lock-file/yarn-parser.spec.ts --coverage=false --maxWorkers=1 --workerIdleMemoryLimit=512M --config jest.config.cts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
