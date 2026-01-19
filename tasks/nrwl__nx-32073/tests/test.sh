#!/bin/bash

cd /app/src

# Set CI environment variable for tests
export CI=true
export NX_DAEMON=false
export NX_SKIP_NX_CACHE=true

# Set Node.js memory limit to 2GB (half of the 4GB available to avoid OOM)
export NODE_OPTIONS="--max-old-space-size=2048"

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/plugin/src/generators/plugin"
cp "/tests/packages/plugin/src/generators/plugin/plugin.spec.ts" "packages/plugin/src/generators/plugin/plugin.spec.ts"

# Run Jest tests for the specific test file using nx CLI
# The plugin package uses Jest for TypeScript tests
# Use --maxWorkers=1 to limit parallelism and reduce memory usage
(cd packages/plugin && npx jest \
  src/generators/plugin/plugin.spec.ts \
  --runTestsByPath \
  --coverage=false \
  --maxWorkers=1)
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
