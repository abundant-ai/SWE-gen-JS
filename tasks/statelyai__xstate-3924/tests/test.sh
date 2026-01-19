#!/bin/bash

cd /app/src

# Clear Jest cache to ensure fresh test run
npx jest --clearCache 2>/dev/null || true

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/actor.test.ts" "packages/core/test/actor.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/behaviors.test.ts" "packages/core/test/behaviors.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/input.test.ts" "packages/core/test/input.test.ts"
mkdir -p "packages/core/test"
cp "/tests/packages/core/test/invoke.test.ts" "packages/core/test/invoke.test.ts"
mkdir -p "packages/xstate-graph/test/__snapshots__"
cp "/tests/packages/xstate-graph/test/__snapshots__/graph.test.ts.snap" "packages/xstate-graph/test/__snapshots__/graph.test.ts.snap"
mkdir -p "packages/xstate-graph/test"
cp "/tests/packages/xstate-graph/test/graph.test.ts" "packages/xstate-graph/test/graph.test.ts"
mkdir -p "packages/xstate-react/test"
cp "/tests/packages/xstate-react/test/useSpawn.test.tsx" "packages/xstate-react/test/useSpawn.test.tsx"
mkdir -p "packages/xstate-solid/test"
cp "/tests/packages/xstate-solid/test/createSpawn.test.tsx" "packages/xstate-solid/test/createSpawn.test.tsx"
mkdir -p "packages/xstate-vue/test"
cp "/tests/packages/xstate-vue/test/UseSpawn.vue" "packages/xstate-vue/test/UseSpawn.vue"

# Rebuild after copying test files to ensure they can import from updated built files
yarn build

# Set up dev symlinks to ensure packages can find each other
npx preconstruct dev

# Run Jest on only the specific test files for this PR
yarn jest \
  packages/core/test/actor.test.ts \
  packages/core/test/behaviors.test.ts \
  packages/core/test/input.test.ts \
  packages/core/test/invoke.test.ts \
  packages/xstate-graph/test/graph.test.ts \
  packages/xstate-react/test/useSpawn.test.tsx \
  packages/xstate-solid/test/createSpawn.test.tsx \
  --coverage=false --runInBand --no-cache
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
