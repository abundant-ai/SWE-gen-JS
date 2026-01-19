#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "__tests__/flow"
cp "/tests/flow/flow.js.flow" "__tests__/flow/flow.js.flow"
mkdir -p "__tests__/flow"
cp "/tests/flow/ts.ts" "__tests__/flow/ts.ts"
mkdir -p "__tests__"
cp "/tests/original.js" "__tests__/original.js"

# Reinstall dependencies to pick up any package.json changes and rebuild to regenerate types
yarn install --frozen-lockfile && yarn build

# Run Jest test for original.js
npx jest __tests__/original.js --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
