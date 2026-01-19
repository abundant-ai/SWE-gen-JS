#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "__tests__"
cp "/tests/tsconfig.json" "__tests__/tsconfig.json"
mkdir -p "__tests__"
cp "/tests/type-external.ts" "__tests__/type-external.ts"

# This test requires type-plus dependency which is added by fix.patch
# Install type-plus temporarily for the test
yarn add -D type-plus@^7.6.2 2>&1 | grep -v "^warning"

# Rebuild TypeScript to pick up the new test files and dependencies
yarn build 2>&1 | grep -E "(error|Error)" || true

# Run TypeScript compiler on just the test file
# The buggy type definition causes type errors that the fix resolves
# We check only the test file with minimal config to avoid unrelated errors
npx tsc --noEmit --skipLibCheck --lib es2015 --strict --target ES5 --moduleResolution node --esModuleInterop --types vitest/globals __tests__/type-external.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
