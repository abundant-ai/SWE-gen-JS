#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "__tests__"
cp "/tests/test.tsconfig.json" "__tests__/test.tsconfig.json"
mkdir -p "__tests__"
cp "/tests/types.ts" "__tests__/types.ts"

# Reinstall dependencies to pick up any package.json changes and rebuild to regenerate types
yarn install && yarn build

# Run Jest test for types.ts
npx jest __tests__/types.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
