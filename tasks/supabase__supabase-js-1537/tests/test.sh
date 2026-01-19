#!/bin/bash

cd /app/src

# Reinstall dependencies in case fix.patch changed package files
npm ci

# Rebuild TypeScript project with the fix applied
npm run build

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "test/integration/next/app"
cp "/tests/integration/next/app/layout.tsx" "test/integration/next/app/layout.tsx"
mkdir -p "test/integration/next"
cp "/tests/integration/next/package.json" "test/integration/next/package.json"
mkdir -p "test/integration/next/tests/types"
cp "/tests/integration/next/tests/types/types.test-d.ts" "test/integration/next/tests/types/types.test-d.ts"
mkdir -p "test/integration/next"
cp "/tests/integration/next/tsconfig.json" "test/integration/next/tsconfig.json"
mkdir -p "test/types"
cp "/tests/types/index.test-d.ts" "test/types/index.test-d.ts"
mkdir -p "test/unit"
cp "/tests/unit/SupabaseClient.test.ts" "test/unit/SupabaseClient.test.ts"

# Run specific unit test file using jest (disable coverage to avoid threshold failures)
npx jest test/unit/SupabaseClient.test.ts --coverage=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
