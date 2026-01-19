#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/ohm-js/test/extras"
cp "/tests/packages/ohm-js/test/extras/test-extractExamples.js" "packages/ohm-js/test/extras/test-extractExamples.js"
mkdir -p "packages/packaging-tests/test"
cp "/tests/packages/packaging-tests/test/test-commonjs.cjs" "packages/packaging-tests/test/test-commonjs.cjs"
mkdir -p "packages/packaging-tests/test"
cp "/tests/packages/packaging-tests/test/test-esm.mjs" "packages/packaging-tests/test/test-esm.mjs"
mkdir -p "packages/packaging-tests/test"
cp "/tests/packages/packaging-tests/test/test-ts.ts" "packages/packaging-tests/test/test-ts.ts"

# Rebuild to pick up any changes from patches (oracle agent applies fix.patch before running tests)
pnpm build

# Run the specific test files from the PR
# ohm-js uses AVA, packaging-tests uses uvu and tsx
cd packages/ohm-js
npx ava test/extras/test-extractExamples.js
ava_status=$?

cd /app/src/packages/packaging-tests
# Run the three packaging test files
npx uvu test test-commonjs.cjs test-esm.mjs
uvu_status=$?

# Run TypeScript test with tsx
npx tsx test/test-ts.ts
tsx_status=$?

# Overall status - all tests must pass
if [ $ava_status -eq 0 ] && [ $uvu_status -eq 0 ] && [ $tsx_status -eq 0 ]; then
  test_status=0
else
  test_status=1
fi

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
