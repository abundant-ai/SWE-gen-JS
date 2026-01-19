#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/query-core/src/tests"
cp "/tests/packages/query-core/src/tests/notifyManager.test.tsx" "packages/query-core/src/tests/notifyManager.test.tsx"
mkdir -p "packages/query-core/src/tests"
cp "/tests/packages/query-core/src/tests/utils.test.tsx" "packages/query-core/src/tests/utils.test.tsx"

# Reset NX cache to avoid cache integrity issues after copying files
npx nx reset || true

# Rebuild all packages after copying test files (needed for type checking across packages)
pnpm run build:all

# Run the specific test files for this PR
cd /app/src/packages/query-core
npx vitest run src/tests/notifyManager.test.tsx src/tests/utils.test.tsx --coverage.enabled=false
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
