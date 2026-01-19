#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/turbo-repository/__tests__"
cp "/tests/packages/turbo-repository/__tests__/affected-packages.test.ts" "packages/turbo-repository/__tests__/affected-packages.test.ts"
mkdir -p "packages/turbo-repository/__tests__/fixtures/npm-monorepo/apps/app"
cp "/tests/packages/turbo-repository/__tests__/fixtures/npm-monorepo/apps/app/package.json" "packages/turbo-repository/__tests__/fixtures/npm-monorepo/apps/app/package.json"
mkdir -p "packages/turbo-repository/__tests__/fixtures/npm-monorepo"
cp "/tests/packages/turbo-repository/__tests__/fixtures/npm-monorepo/package-lock.json" "packages/turbo-repository/__tests__/fixtures/npm-monorepo/package-lock.json"
mkdir -p "packages/turbo-repository/__tests__/fixtures/npm-monorepo"
cp "/tests/packages/turbo-repository/__tests__/fixtures/npm-monorepo/package.json" "packages/turbo-repository/__tests__/fixtures/npm-monorepo/package.json"
mkdir -p "packages/turbo-repository/__tests__/fixtures/npm-monorepo/packages/blank"
cp "/tests/packages/turbo-repository/__tests__/fixtures/npm-monorepo/packages/blank/package.json" "packages/turbo-repository/__tests__/fixtures/npm-monorepo/packages/blank/package.json"
mkdir -p "packages/turbo-repository/__tests__/fixtures/npm-monorepo/packages/ui"
cp "/tests/packages/turbo-repository/__tests__/fixtures/npm-monorepo/packages/ui/package.json" "packages/turbo-repository/__tests__/fixtures/npm-monorepo/packages/ui/package.json"

# Run specific test file with Node.js test runner
cd packages/turbo-repository
node --import tsx --test __tests__/affected-packages.test.ts
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
