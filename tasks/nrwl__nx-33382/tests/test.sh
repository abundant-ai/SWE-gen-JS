#!/bin/bash

cd /app/src

# Set CI environment variable for tests
export CI=true
export NX_DAEMON=false
export NX_SKIP_NX_CACHE=true

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/nx/src/command-line/release/changelog"
cp "/tests/packages/nx/src/command-line/release/changelog/commit-utils.spec.ts" "packages/nx/src/command-line/release/changelog/commit-utils.spec.ts"
mkdir -p "packages/nx/src/command-line/release/config"
cp "/tests/packages/nx/src/command-line/release/config/config.spec.ts" "packages/nx/src/command-line/release/config/config.spec.ts"
mkdir -p "packages/nx/src/command-line/release/utils"
cp "/tests/packages/nx/src/command-line/release/utils/semver.spec.ts" "packages/nx/src/command-line/release/utils/semver.spec.ts"

# Run Jest tests for the specific test files using the nx package's config
cd packages/nx
npx jest src/command-line/release/changelog/commit-utils.spec.ts src/command-line/release/config/config.spec.ts src/command-line/release/utils/semver.spec.ts --coverage=false --maxWorkers=1 --workerIdleMemoryLimit=512M --config jest.config.cts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
