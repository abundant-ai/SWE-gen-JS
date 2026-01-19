#!/bin/bash

set -o pipefail

cd /app/src

# Set Node memory limit to avoid OOM in constrained environments
export NODE_OPTIONS="--max-old-space-size=3072"

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/actor.test.ts" "packages/core/test/actor.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/invoke.test.ts" "packages/core/test/invoke.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/system.test.ts" "packages/core/test/system.test.ts"
mkdir -p "packages/xstate-react/test"
cp "/tests/packages/xstate-react/test/useSelector.test.tsx" "packages/xstate-react/test/useSelector.test.tsx"
mkdir -p "packages/xstate-vue/test"
cp "/tests/packages/xstate-vue/test/UseSelectorSimple.vue" "packages/xstate-vue/test/UseSelectorSimple.vue"

# Rebuild the project to regenerate type definitions
# This ensures .d.ts files match the current source (buggy or fixed)
yarn build 2>&1 > /dev/null
build_status=$?

if [ $build_status -ne 0 ]; then
  # Build failed
  test_status=1
else
  # Run type checking on the project to catch type errors
  # This will fail if test files have type mismatches with the built definitions
  yarn typecheck 2>&1 | head -100
  typecheck_status=$?

  if [ $typecheck_status -ne 0 ]; then
    # Type checking failed - type errors detected
    test_status=1
  else
    # Type checking passed, run the specific test files with Jest
    npx jest packages/core/test/actor.test.ts packages/core/test/invoke.test.ts packages/core/test/system.test.ts packages/xstate-react/test/useSelector.test.tsx packages/xstate-vue/test/UseSelectorSimple.vue --coverage=false
    test_status=$?
  fi
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
