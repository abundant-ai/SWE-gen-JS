#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/typescript-tests"
cp "/tests/typescript-tests/testTypes.ts" "test/typescript-tests/testTypes.ts"
mkdir -p "test/unit-tests/function/arithmetic"
cp "/tests/unit-tests/function/arithmetic/ceil.test.js" "test/unit-tests/function/arithmetic/ceil.test.js"
mkdir -p "test/unit-tests/function/arithmetic"
cp "/tests/unit-tests/function/arithmetic/fix.test.js" "test/unit-tests/function/arithmetic/fix.test.js"
mkdir -p "test/unit-tests/function/arithmetic"
cp "/tests/unit-tests/function/arithmetic/floor.test.js" "test/unit-tests/function/arithmetic/floor.test.js"

# Run TypeScript tests with ts-node loader
node --loader ts-node/esm ./test/typescript-tests/testTypes.ts
ts_status=$?

# Run JavaScript unit tests with mocha
npx mocha test/unit-tests/function/arithmetic/ceil.test.js test/unit-tests/function/arithmetic/fix.test.js test/unit-tests/function/arithmetic/floor.test.js
js_status=$?

# Both must pass
if [ $ts_status -eq 0 ] && [ $js_status -eq 0 ]; then
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
