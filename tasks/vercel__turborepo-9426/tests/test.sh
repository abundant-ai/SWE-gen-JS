#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/eslint-plugin-turbo/__tests__"
cp "/tests/packages/eslint-plugin-turbo/__tests__/cwd.test.ts" "packages/eslint-plugin-turbo/__tests__/cwd.test.ts"
mkdir -p "packages/eslint-plugin-turbo/__tests__"
cp "/tests/packages/eslint-plugin-turbo/__tests__/cwdFlat.test.ts" "packages/eslint-plugin-turbo/__tests__/cwdFlat.test.ts"

# Rebuild the eslint-plugin-turbo package (needed after Oracle applies fix.patch)
cd packages/eslint-plugin-turbo
pnpm run build

# Run specific test files with Jest
pnpm test __tests__/cwd.test.ts __tests__/cwdFlat.test.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
