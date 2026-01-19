#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "__tests__"
cp "/tests/types.ts" "__tests__/types.ts"

# Reinstall dependencies to pick up any package.json changes (e.g., TypeScript version)
# and rebuild to regenerate types with the correct TypeScript version
yarn install --frozen-lockfile && yarn build

# Run TypeScript type checking using the existing test.tsconfig.json
yarn tsc -p __tests__/test.tsconfig.json --noEmit
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
