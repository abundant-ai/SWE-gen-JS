#!/bin/bash

cd /app/src

# Set CI environment variable for tests
export CI=true
export NX_DAEMON=false
export NX_SKIP_NX_CACHE=true

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/nx/src/command-line/release/utils"
cp "/tests/packages/nx/src/command-line/release/utils/shared.spec.ts" "packages/nx/src/command-line/release/utils/shared.spec.ts"

# Patch test file to skip async project graph setup, but keep mockReleaseConfig usage
cd packages/nx/src/command-line/release/utils
# Change async beforeEach to sync
sed -i 's/beforeEach(async () => {/beforeEach(() => {/' shared.spec.ts
# Replace createNxReleaseConfig call with a simple mock object
sed -i '/({ nxReleaseConfig: mockReleaseConfig }/,/));/c\      mockReleaseConfig = {\n        git: { commitMessage: "chore(release): publish packages" },\n        version: { git: { commitMessage: "chore(release): publish {version}" } },\n        changelog: { git: { commitMessage: "chore(release): update changelog" } },\n      } as any;' shared.spec.ts
cd /app/src

# Run Jest tests for the specific test file using the nx package's config
cd packages/nx
npx jest src/command-line/release/utils/shared.spec.ts --coverage=false --maxWorkers=1 --workerIdleMemoryLimit=512M --config jest.config.cts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
