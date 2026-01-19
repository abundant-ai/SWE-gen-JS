#!/bin/bash

cd /app/src

# Rebuild to reflect any changes from agent (e.g., Oracle applying fix.patch)
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/typescript-tests"
cp "/tests/typescript-tests/testTypes.ts" "test/typescript-tests/testTypes.ts"
mkdir -p "test/unit-tests/function/matrix"
cp "/tests/unit-tests/function/matrix/eigs.test.js" "test/unit-tests/function/matrix/eigs.test.js"

# Run TypeScript test with ts-node ESM loader
node --loader ts-node/esm ./test/typescript-tests/testTypes.ts
ts_status=$?

if [ $ts_status -ne 0 ]; then
  echo "TypeScript test failed"
  echo 0 > /logs/verifier/reward.txt
  exit $ts_status
fi

# Run JavaScript test with mocha
npx mocha test/unit-tests/function/matrix/eigs.test.js
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
