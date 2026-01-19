#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/react-query/src/__tests__"
cp "/tests/packages/react-query/src/__tests__/useQueries.test-d.tsx" "packages/react-query/src/__tests__/useQueries.test-d.tsx"
mkdir -p "packages/vue-query/src/__tests__"
cp "/tests/packages/vue-query/src/__tests__/useQueries.types.test.ts" "packages/vue-query/src/__tests__/useQueries.types.test.ts"

# Reset NX cache to avoid cache integrity issues after copying files
npx nx reset

# Rebuild packages after copying test files
cd /app/src/packages/query-core
pnpm run build
cd /app/src/packages/react-query
pnpm run build
cd /app/src/packages/vue-query
pnpm run build
cd /app/src

# Run the specific test files for this PR
cd /app/src/packages/react-query
pnpm run test:lib src/__tests__/useQueries.test-d.tsx
react_test_status=$?

cd /app/src/packages/vue-query
pnpm run test:lib src/__tests__/useQueries.types.test.ts
vue_test_status=$?

# Both tests must pass
if [ $react_test_status -eq 0 ] && [ $vue_test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
  exit 0
else
  echo 0 > /logs/verifier/reward.txt
  exit 1
fi
