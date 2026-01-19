#!/bin/bash

cd /app/src

# Set CI environment variable for tests
export CI=true
export NX_DAEMON=false
export NX_SKIP_NX_CACHE=true

# Set Node.js memory limit to 2GB (half of the 4GB available to avoid OOM)
export NODE_OPTIONS="--max-old-space-size=2048"

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/nx/src/native/tests"
cp "/tests/packages/nx/src/native/tests/cache.spec.ts" "packages/nx/src/native/tests/cache.spec.ts"
mkdir -p "packages/nx/src/native/tests"
cp "/tests/packages/nx/src/native/tests/task_history.spec.ts" "packages/nx/src/native/tests/task_history.spec.ts"

# Run Jest tests for the specific test files using nx CLI
# The nx package uses Jest for TypeScript tests
# Use --maxWorkers=1 to limit parallelism and reduce memory usage
(cd packages/nx && npx jest \
  src/native/tests/cache.spec.ts \
  src/native/tests/task_history.spec.ts \
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
