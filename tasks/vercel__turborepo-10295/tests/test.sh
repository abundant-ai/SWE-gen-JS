#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/turbo-codemod/__tests__"
cp "/tests/packages/turbo-codemod/__tests__/migrate-env-var-dependencies.test.ts" "packages/turbo-codemod/__tests__/migrate-env-var-dependencies.test.ts"
mkdir -p "packages/turbo-codemod/__tests__"
cp "/tests/packages/turbo-codemod/__tests__/set-default-outputs.test.ts" "packages/turbo-codemod/__tests__/set-default-outputs.test.ts"
mkdir -p "packages/turbo-codemod/__tests__"
cp "/tests/packages/turbo-codemod/__tests__/stabilize-env-mode.test.ts" "packages/turbo-codemod/__tests__/stabilize-env-mode.test.ts"
mkdir -p "packages/turbo-codemod/__tests__"
cp "/tests/packages/turbo-codemod/__tests__/transform-env-literals-to-wildcards.test.ts" "packages/turbo-codemod/__tests__/transform-env-literals-to-wildcards.test.ts"

# Run specific test files with Jest (disable coverage collection to avoid threshold errors)
cd packages/turbo-codemod
pnpm exec jest --collectCoverage=false __tests__/migrate-env-var-dependencies.test.ts __tests__/set-default-outputs.test.ts __tests__/stabilize-env-mode.test.ts __tests__/transform-env-literals-to-wildcards.test.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
