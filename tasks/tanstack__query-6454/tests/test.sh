#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/react-query/src/__tests__"
cp "/tests/packages/react-query/src/__tests__/useQueries.test.tsx" "packages/react-query/src/__tests__/useQueries.test.tsx"

# Reset NX cache to avoid cache integrity issues after copying files
npx nx reset || true

# Rebuild all packages after copying test files (needed for type checking across packages)
pnpm run build:all

# This is a TypeScript type-level bug - run type checking on the react-query package
# The bug causes type errors in the test file when using queryOptions with select
cd /app/src/packages/react-query
npx tsc --noEmit
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
