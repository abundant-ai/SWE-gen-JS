#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "__tests__/flow"
cp "/tests/flow/.flowconfig" "__tests__/flow/.flowconfig"
mkdir -p "__tests__/flow"
cp "/tests/flow/flow.js.flow" "__tests__/flow/flow.js.flow"
mkdir -p "__tests__"
cp "/tests/tsconfig.json" "__tests__/tsconfig.json"
mkdir -p "__tests__"
cp "/tests/types.ts" "__tests__/types.ts"

# Run TypeScript type checking on __tests__/tsconfig.json
yarn tsc -p __tests__/tsconfig.json --noEmit
ts_status=$?

# Run Flow type checking on __tests__/flow
yarn flow check __tests__/flow
flow_status=$?

# Both must pass for the test to pass
if [ $ts_status -eq 0 ] && [ $flow_status -eq 0 ]; then
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
