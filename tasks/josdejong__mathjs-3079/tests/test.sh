#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/typescript-tests"
cp "/tests/typescript-tests/testTypes.ts" "test/typescript-tests/testTypes.ts"

# Run TypeScript tests with ts-node ESM loader
node --loader ts-node/esm ./test/typescript-tests/testTypes.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
