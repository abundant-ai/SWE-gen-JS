#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/query-core/src/__tests__"
cp "/tests/packages/query-core/src/__tests__/queryObserver.test.tsx" "packages/query-core/src/__tests__/queryObserver.test.tsx"

# Reset NX cache to avoid cache integrity issues after copying files
npx nx reset

# Rebuild query-core package after copying test files
cd /app/src/packages/query-core
pnpm run build
cd /app/src

# Run the specific test file for queryObserver
cd /app/src/packages/query-core
pnpm run test:lib src/__tests__/queryObserver.test.tsx
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
