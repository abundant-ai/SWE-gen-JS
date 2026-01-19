#!/bin/bash

cd /app/src

# Clear Jest cache to ensure fresh test run
npx jest --clearCache 2>/dev/null || true

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/xstate-fsm/test"
cp "/tests/packages/xstate-fsm/test/fsm.test.ts" "packages/xstate-fsm/test/fsm.test.ts"
mkdir -p "packages/xstate-svelte/test"
cp "/tests/packages/xstate-svelte/test/UseFsm.svelte" "packages/xstate-svelte/test/UseFsm.svelte"

# Rebuild after copying test files to ensure they can import from updated built files
yarn build

# Set up dev symlinks to ensure packages can find each other
npx preconstruct dev

# Run Jest on only the specific test files for this PR
yarn jest \
  packages/xstate-fsm/test/fsm.test.ts \
  --coverage=false --runInBand --no-cache
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
