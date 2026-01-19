#!/bin/bash

cd /app/src

# Copy HEAD test files from /tests (overwrites BASE state)
mkdir -p "packages/react-query/src/__tests__"
cp "/tests/packages/react-query/src/__tests__/useQuery.types.test.tsx" "packages/react-query/src/__tests__/useQuery.types.test.tsx"

# Build types for dependencies
cd /app/src/packages/query-core
pnpm run build:types >/dev/null 2>&1

# For types tests, use TypeScript compiler with proper jsx handling
cd /app/src/packages/react-query
npx tsc --noEmit --jsx preserve --esModuleInterop --skipLibCheck --module esnext --target esnext --moduleResolution node src/__tests__/useQuery.types.test.tsx
test_status=$?

if [ $test_status -eq 0 ]; then
  echo 1 > /logs/verifier/reward.txt
else
  echo 0 > /logs/verifier/reward.txt
fi
exit "$test_status"
