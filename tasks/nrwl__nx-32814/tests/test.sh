#!/bin/bash

cd /app/src

# Set CI environment variable for tests
export CI=true
export NX_DAEMON=false
export NX_SKIP_NX_CACHE=true

# Set Node.js memory limit to 2GB (half of the 4GB available to avoid OOM)
export NODE_OPTIONS="--max-old-space-size=2048"

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/react/src/generators/init"
cp "/tests/packages/react/src/generators/init/init.spec.ts" "packages/react/src/generators/init/init.spec.ts"

# Run Jest tests for the specific test file
# Use --forceExit to prevent hanging and --testTimeout to avoid spurious timeouts
test_status=0

npx jest packages/react/src/generators/init/init.spec.ts --coverage=false --runInBand --forceExit --testTimeout=60000 || test_status=1

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
